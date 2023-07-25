import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/user/view/sign_in.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 200,
              height: 120,
            ),
            Center(
              child: Container(
                color: Colors.red,
                width: 280,
                height: 280,
              ),
            ),
            const SizedBox(
              width: 200,
              height: 120,
            ),
            Center(
              child:  InkWell(
                child: Image.asset(
                      'assets/images/kakao_login_medium_wide.png',
                    ),
                onTap: ()
                {
                 print("카카오 로그인");
                 Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => SignIn(),),
                 );
                },
              ),
            ),
          ],

        ),
        backgroundColor: BACKGROUND_COLOR,
      );
  }
}