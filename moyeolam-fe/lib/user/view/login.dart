import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/user/viewmodel/login_view_model.dart';
import 'package:youngjun/data/model/user_model.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late List<User> userList;

  @override
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
          Center(child:
              Consumer<UserViewModel>(builder: (context, provider, child) {
            userList = provider.userList;
            return InkWell(
              child: Image.asset(
                'assets/images/kakao_login_medium_wide.png',
              ),
              onTap: () {
                print("카카오 로그인");
                UserViewModel();
                print("$userList");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SetNickname(),
                //   ),
                // );
              },
            );
          })),
        ],
      ),
      backgroundColor: BACKGROUND_COLOR,
    );
  }
}
