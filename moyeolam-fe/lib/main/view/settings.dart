import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/button/btn_toggle.dart';
import 'package:youngjun/common/const/address_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../common/confirm.dart';
import '../../common/layout/main_nav.dart';
import '../../fcm/api/fcm_api.dart';


class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Setting page',
      home: Scaffold(
        backgroundColor: LIST_BLACK_COLOR,
        body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildText('알림 설정', context),
                  FutureBuilder<bool>(
                    future: fetchNotificationStatus(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        bool currentStatus = snapshot.data ?? false;
                        return BtnToggle(
                          value: currentStatus,
                          onChanged: (bool newValue) {
                            print('바뀌었다!');
                            updateNotificationStatus(!currentStatus); // 토글 동작 실행
                          },
                        );
                      }
                    },
                  ),


                ],
              ),
              buildDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildText('버전 정보', context),
                  buildText('버전 쓸곳', context),
                ],
              ),
              buildDivider(),
              buildText('개발자 정보', context),

              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('로그아웃'),
                      content: Text('로그아웃 하시겠습니까?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('취소'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text('확인'),
                        ),
                      ],
                    ),
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
                        Navigator.pushNamed(context, '/sign_out');
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
        ),
      ),
    );
  }


  // FCM 알림을 처리하는 함수
  Future<void> handleFCMNotification(RemoteMessage? message) async {
    bool notificationStatus = await fetchNotificationStatus();
    // 다른 파일에 있는 handleMessage 함수 호출 부분
    handleMessage(message, notificationStatus);

    if (notificationStatus) {
      print('FCM 알림을 처리');

    } else {
      // 알림 설정이 비활성화된 상태일 때
      print('알림 설정이 비활성화되어 알림을 무시합니다.');
    }
  }

// 서버에 새로운 알림 상태를 업데이트하는 함수
  void updateNotificationStatus(bool status) async {
    var dio = Dio();
    dio.options.baseUrl = BASE_URL;
    final alarmGroupId = 'API 요청한 ID!!! 사용 -> 뭔데~~~~~~~~';
    try {
      await dio.post('/alarmgroups/$alarmGroupId/toggle', data: {'status': status});
      print('알림 설정이 업데이트되었습니다.');
      // 토글된 상태로 변경한 후 다시 알림 상태를 가져와서 화면을 업데이트
      fetchAndRefreshNotificationStatus();
      RemoteMessage tempMessage = RemoteMessage(
        notification: RemoteNotification(
          title: 'Temp',
          body: 'FCM notification',
        ),
      );

      // FCM 알림 처리 함수를 호출할 때 임의의 RemoteMessage 객체를 넘겨줍니다.
      handleFCMNotification(tempMessage);
    } catch (e) {
      print('알림 설정 업데이트 오류: $e');
    }
  }


  // 알림 상태를 가져와서 화면을 업데이트
  void fetchAndRefreshNotificationStatus() {
    // 토글한 후 알림 상태를 다시 가져오고 화면을 업데이트합니다.
    fetchNotificationStatus().then((status) {
      // 화면 업데이트 관련
    });
  }


  Widget buildText(String text, BuildContext context) {
    return Text(
        text,
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 2.0, // 자간을 좁게 설정
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
          child: Divider(
              color: MAIN_COLOR,
              thickness: 1.5
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
