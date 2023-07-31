import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/user/model/user_model.dart';
import 'package:youngjun/user/viewmodel/login_view_model.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
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
          Center(
            child: InkWell(
              child: Image.asset(
                'assets/images/kakao_login_medium_wide.png',
              ),
              onTap: () {
                UserViewModel().login();
                print("카카오 로그인");

                var usrNickname = Provider((ref) {
                  var usr = ref.watch(userProvider);
                  return usr;
                });
                print((usrNickname));
                // UserViewModel();
                // print("$userList");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SetNickname(),
                //   ),
                // );
              },
            ),
          ),
        ],
      ),
      backgroundColor: BACKGROUND_COLOR,
    );
  }
}
