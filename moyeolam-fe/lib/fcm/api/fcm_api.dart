import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:youngjun/main.dart';

import '../view/arlet_list_view.dart';

void handleMessage(RemoteMessage message) {
  // 푸시 알림을 처리하는 로직 구현
  // 푸시 알림이 눌렸을 때 특정 화면으로 이동하거나 알림 내용을 표시하는 등의 작업 수행

  // 예를 들어, 푸시 알림이 어떤 내용을 담고 있는지 확인하여 해당 정보를 알려주는 화면으로 이동
  if (message.notification != null) {
    Navigator.of(navigatorKey.currentContext!).pushNamed(
      ArletListView.route,
      arguments: message,
    );
  }
}

Future<void> initLocalNotifications() async {
  final FlutterLocalNotificationsPlugin _localNotification = FlutterLocalNotificationsPlugin();

  const android = AndroidInitializationSettings('drawable/ic_launcher');
  const setting = InitializationSettings(android: android);

  await _localNotification.initialize(
    setting,
    onSelectNotification: (String? payload) async {
      if (payload != null) {
        final message = RemoteMessage.fromMap(jsonDecode(payload));
        handleMessage(message);
      }
    },
  );

  final platform = _localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  await platform?.createNotificationChannel(AndroidNotificationChannel(
    'high_importance_channel',
    '중요한 알림',
    importance: Importance.high,
  ));
}






Future<void> initPushNotifications() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  FirebaseMessaging.onBackgroundMessage(handleMessage);
}



// @pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // 이 함수는 FCM 메시지를 백그라운드에서 처리하는 핸들러입니다. 백그라운드에서 FCM 메시지를 수신할 때 호출되며, 수신한 메시지의 타이틀과 내용을 출력합니다.
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print(message.notification?.body);
  initPushNotifications();
  handleMessage(message);

}


// ChangeNotifier를 상속하고 있으며, FCM 관련 기능을 제공하는 Provider 클래스입니다. FCM을 초기화하고, 토큰을 얻어오며, 백그라운드 메시지 핸들러를 등록하고, 수신한 메시지를 저장하는 등의 기능이 포함되어 있습니다.
class FirebaseApi with ChangeNotifier {
  final _firebaseMessaging = FirebaseMessaging.instance;
  // String? fcmToken;

  RemoteMessage? latestMessage; // 수신한 마지막 메시지 저장

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();
    print('Token:  $fcmToken');
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    // FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
    //   // save token to server
    // });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // 여기에 특정 페이지로 이동하는 로직을 정의
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (context) => YourTargetPage()),
      // );

      latestMessage = message; // 메시지 저장
      notifyListeners(); // 변경 알림
    });

    // FirebaseMessaging.instance.deleteToken();

    notifyListeners();
    initPushNotifications();
    initLocalNotifications();
  }

// Further FCM methods can go here
}
