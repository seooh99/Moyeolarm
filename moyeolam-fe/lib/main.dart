import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:youngjun/main/view/settings.dart';
// import 'package:youngjun/user/view/login.dart';

import 'package:youngjun/user/view/set_nickname.dart';

// import 'package:youngjun/user/view/sign_in.dart';

// import 'common/const/alarm_list.dart';
import 'common/layout/main_nav.dart';
// import 'main/view/alarm_list.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => FcmProvider(),
      child: _Moyuram(),
    ),
  );
}

Future<void> _configureFirebaseMessaging() async {
  var fcmToken = await FirebaseMessaging.instance.getToken(vapidKey: "BCbCyGkfT1KJoi7vI-4oS96nXrzxejo1Hb9Boa0b4a17OIAoBNVsYzZdkx");

  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
    // save token to server
  });

  FirebaseMessaging.instance.deleteToken();
}

class _Moyuram extends StatelessWidget {
  const _Moyuram({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // context.read<FcmProvider>().configureFirebaseMessaging();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Scaffold(
        //       body: MainNav(
        //     appBar: AppBar(
        //     title: Text('Main Navigation'),
        // ),
        // bodyWidgets: [
        // Center(child: Text('First Page')),
        // Center(child: Text('Second Page')),
        // Center(child: Text('Third Page')),
        // ],
        // ),


      initialRoute: '/settings',
      routes: {
        '/': (context) => Login(),
        // 초기 라우트로 카카오로그인페이지 설정
        // '/set_nickname' : (context) => SignIn(),
        '/main_alarm_list': (context) => AlarmAddScreen(),
        // 알람 초대 confirm (모달창 주소필요없음)
        // 친구 초대 confirm (모달창 주소필요없음)
        // 친구목록리스트(nav)
        // setting(nav)
        '/settings': (context) => Settings(),
        // '/alarm_build' : (context) => ,
        // '/alarm_rebuild' : (context) => ,
        // '/alarm_room_king' : (context) =>, // 이건 방장(닉네임 or 아이디으로도 차별 줘야함)
        // '/alarm_room_sub' : (context) =>, // 이건 방장칭구칭구(닉네임 or 아이디으로도 차별 줘야함)
        // 반복요일 설정
        // 알람음 설정
        // 인증방식 설정
        // 개발자정보 필요해?? -> 회의 필요~~~
        // 로그아웃 confirm (모달창 주소필요없음)
        // 회원탈퇴 페이지
        // 닉네임 변경은 그냥?
        // 친구검색은 페이지 변경 X?
        // 친구 삭제 confirm (모달창 주소필요없음)
        // '/on_alarm' : (context) => ,알람 울리는 page
        // 'web_rtc' : (context) => , 화상 알람
      },
    );
  }
}

