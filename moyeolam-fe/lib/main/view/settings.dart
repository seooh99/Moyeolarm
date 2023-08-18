import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/scheduler.dart';
import 'package:moyeolam/common/const/address_config.dart';
import 'package:moyeolam/common/const/colors.dart';
import 'package:moyeolam/common/button/btn_toggle.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../common/confirm.dart';


import '../../common/secure_storage/secure_storage.dart';
import '../../fcm/view/alert_list_view.dart';
import '../../user/model/user_model.dart';
import '../../user/view/auth.dart';
import '../../user/viewmodel/auth_view_model.dart';
import '../service/setting_service.dart';


import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:moyeolam/main.dart';


bool globalNotificationStatus = true;


void handleMessage(RemoteMessage? message, bool notificationStatus) {
  if (!notificationStatus) {
    return;
  }

}

Future<void> initLocalNotifications() async {
  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  const setting = InitializationSettings(android: android);

  final FlutterLocalNotificationsPlugin _localNotification = FlutterLocalNotificationsPlugin();

  await FlutterLocalNotificationsPlugin().initialize(
    setting,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      final payload = response.payload ?? '';
      final parsedJson = jsonDecode(payload);
      if (parsedJson.containsKey('routeTo') && parsedJson['routeTo'] == '/arlet_list') {


      }
    },
  );

  final platform = _localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  await platform?.createNotificationChannel(AndroidNotificationChannel(
    'my_notification_channel',
    'My Notification Channel',
    importance: Importance.high,
  ));
}



Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  // print(message.data);



}



Future<void> initPushNotifications() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User한테 permission: ${settings.authorizationStatus}');

  _SettingsContentState settingsContentState = _SettingsContentState();

  bool notificationStatus = settingsContentState._notificationStatus;

  FirebaseMessaging.instance.getInitialMessage().then((message) {
    handleMessage(message, notificationStatus);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    handleMessage(message, notificationStatus);

  });


  initLocalNotifications();



}



class FirebaseApi with ChangeNotifier {
  final _firebaseMessaging = FirebaseMessaging.instance;
  // String? fcmToken;

  RemoteMessage? latestMessage; // 수신한 마지막 메시지 저장

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();
    print('Token:  $fcmToken');
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((event) {

      if (GlobalVariable.navState.currentContext != null) {
          Navigator.of(GlobalVariable.navState.currentContext!)
              .push(MaterialPageRoute(
              builder: (context) => ArletListView())); // 이거 로직은 좀 더 생각

          return;
        }


      notifyListeners(); // 변경 알림


    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

      if (GlobalVariable.navState.currentContext != null) {
        if(message.data['screen'] == 'MainPage') {
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(GlobalVariable.navState.currentContext!)
                .push(MaterialPageRoute(
                builder: (context) => ArletListView()));
          });
          return;
        }
      }

    });

    notifyListeners();
    initPushNotifications();
    initLocalNotifications();
  }

}







class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Setting page',
      home: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        body: _SettingsContent(),
      ),
    );
  }
}

class _SettingsContent extends StatefulWidget {
  @override
  _SettingsContentState createState() => _SettingsContentState();
}

class _SettingsContentState extends State<_SettingsContent> {
  bool _notificationStatus = true; // 일
  SettingService settingService = SettingService(Dio(), baseUrl: BASE_URL);



  @override
  void initState() {
    fetchSettingStatus();
    super.initState();
  }

  final dio = Dio();
  final UserInformation _userInformation = UserInformation(storage);


  Future<void> fetchSettingStatus() async {
    try {
      UserModel? userInfo = await _userInformation.getUserInfo();
      if (userInfo == null) {
        print("User info not found.");
        return;
      }
      String token = "Bearer ${userInfo.accessToken}";
      final settingfetch = await settingService.getSettings(token);

      if (settingfetch != null && settingfetch.data != null) {
        final notificationStatus = settingfetch.data?.isNotificationToggle;
        setState(() {
          _notificationStatus = notificationStatus ?? false;
        });

        print('fetch 성공!!!!');
        print(settingfetch.data?.isNotificationToggle);
      } else {
        throw Exception('fetch 노테이션 실패');
      }
    } catch (error) {
      print('에러입니다 여기에러인가: $error');
    }
  }

  Future<void> updateSettingStatus(bool status) async {
    try {
      UserModel? userInfo = await _userInformation.getUserInfo();
      if (userInfo == null) {
        print("User info not found.");
        return;
      }
      String token = "Bearer ${userInfo.accessToken}";

      final settingupdate = await settingService.patchSettings(token, status);
      print('Setting Update Response: $settingupdate');

      if (settingupdate != null && settingupdate.data != null) {
        setState(() {
          _notificationStatus = status;
          globalNotificationStatus = status;  // 전역 변수 동기화
        });
        print('Update 성공');
        print(settingupdate.data);
      }
    } catch (e) {
      print('업데이트 에러: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildText('알림 설정', context),
              BtnToggle(
                value: _notificationStatus,
                onChanged: (bool newValue) {
                  updateSettingStatus(newValue); // 토글 동작 실행
                },
              ),
            ],
          ),
          buildDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildText('버전 정보', context),
              buildText('v1.05', context),
            ],
          ),
          buildDivider(),
          buildText('개발자 정보', context),
          InkWell(
            onTap: () {
              showpopup(
                context,
                '로그아웃',
                '지금 로그아웃 하시겠습니까?',
                '예',
                '아니오',
                    () async {
                  // 예
                  await AuthViewModel().logOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AuthView(),
                  )
                  );
                },
                    () {
                  // 아니오
                },
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDivider(),
                buildText('로그아웃', context),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              showpopup(
                context,
                '회원탈퇴',
                '지금 회원탈퇴 하시겠습니까?',
                '예',
                '아니오',
                    () async {
                  await AuthViewModel().signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AuthView(),
                  ));
                },
                    () {
                  Navigator.pop(context);
                },
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDivider(),
                buildText('회원탈퇴', context),
              ],
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Widget buildText(String text, BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: FONT_COLOR,
        letterSpacing: 2.0,
        fontSize: 24.0,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget buildDivider() {
    return Column(
      children: [
        Container(
          width: 500,
          child: Divider(color: MAIN_COLOR, thickness: 1.5),
        ),
        SizedBox(height: 15.0),
      ],
    );
  }
}

void showpopup(
    BuildContext context,
    String title,
    String content,
    String okTitle,
    String cancelTitle,
    VoidCallback okOnPressed,
    VoidCallback cancelOnPressed,
    ) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return ConfirmDialog(
        cancelOnPressed: () {
          if (cancelOnPressed != null) {
            cancelOnPressed();
            Navigator.pop(context);
          }
        },
        okOnPressed: () {
          if (okOnPressed != null) {
            okOnPressed();
            Navigator.pop(context);
          }
        },
        title: title,
        content: content,
        okTitle: okTitle,
        cancelTitle: cancelTitle,
      );
    },
  );
}
