import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/button/btn_toggle.dart';
import 'package:youngjun/common/const/address_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../common/layout/main_nav.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Setting page',
      home: Scaffold(
        backgroundColor: LIST_BLACK_COLOR,
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

  @override
  void initState() {
    super.initState();
    fetchNotificationStatus();
  }

  Future<void> fetchNotificationStatus() async {
    try {
      final dio = Dio();
      dio.options.baseUrl = BASE_URL;

      final response = await dio.patch(
          '/member/settings/notification-toggle');

      if (response.statusCode == 200) {
        print('fetch 성공');
        final responseData = response.data;
        final notificationStatus = responseData['data'];
        setState(() {
          _notificationStatus = notificationStatus;
        });
      } else {
        throw Exception('fetch 노테이션 실패');
      }
    } catch (error) {
      print('에러입니다 여기에러인가: $error');
    }
  }

  Future<void> updateNotificationStatus(bool status) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = BASE_URL;


      var response = await dio.patch(
          '/member/settings/notification-toggle',
          data: {'status': status});

      setState(() {
        _notificationStatus = status;
      });
    print('${response?.data}update 성공');


    } catch (e) {
      print('Error updating notification status: $e');
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
                  updateNotificationStatus(newValue); // 토글 동작 실행
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
              // Handle logout logic
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
              // Handle sign out logic
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
        color: Colors.white,
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
