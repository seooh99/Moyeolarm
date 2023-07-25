import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/button/btn_toggle.dart';



class Settings extends StatelessWidget {
  const Settings({super.key});

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
                  buildText('알림 설정'),
                  BtnToggle(),
                ],
              ),
              buildDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildText('버전 정보'),
                  buildText('버전 쓸곳'),
                ],
              ),
              buildDivider(),
              buildText('개발자 정보'),
              buildDivider(),
              buildText('로그아웃'),
              buildDivider(),
              buildText('회원탈퇴'),
              buildDivider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildText(String text) {
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
