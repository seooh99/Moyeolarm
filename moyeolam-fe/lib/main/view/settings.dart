import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/button/btn_toggle.dart';

import '../../common/confirm.dart';



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
                        return BtnToggle(
                          value: snapshot.data ?? false,
                          onChanged: (bool newValue) {
                            print('바뀌었다!');
                            updateNotificationStatus(newValue);
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
              buildDivider(),
              buildText('로그아웃', context),
              buildDivider(),
              buildText('회원탈퇴', context),
              buildDivider(),
            ],
          ),
        ),
      ),
    );
  }

  // 서버에서 현재 알림 상태를 가져오는 함수
  Future<bool> fetchNotificationStatus() async {
    var dio = Dio();
    var response = await dio.get('YOUR_API_ENDPOINT');
    return response.data['status']; // API 응답에 따라 적절히 수정해야 합니다.
  }

// 서버에 새로운 알림 상태를 업데이트하는 함수
  void updateNotificationStatus(bool status) async {
    var dio = Dio();
    await dio.post('YOUR_API_ENDPOINT', data: {'status': status});
    // API 엔드포인트와 전송하는 데이터는 실제 API에 맞게 조정해야 합니다.
  }



  Widget buildText(String text, BuildContext context) {
    return InkWell(
      onTap: () {
        if (text == '로그아웃') {
          showDialog(
            context: context,
            barrierDismissible: true, // 바깥 영역 터치시
            builder: (BuildContext context) => DialogExample(
              cancelOnPressed: () => Navigator.pop(context),
              okOnPressed: () {
                Navigator.pop(context); // 먼저 모달을 닫음
                Navigator.pushNamed(context, '/'); // 그 다음 '/'로 라우트
              },
              // title: '로그아웃 확인',
              // description: '로그아웃 하시겠습니까?',
              // cancelButtonText: '아니오',
              // okButtonText: '예',
            ),
          );
        }
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 2.0, // 자간을 좁게 설정
          fontSize: 24.0,
          fontWeight: FontWeight.normal,
        ),
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
