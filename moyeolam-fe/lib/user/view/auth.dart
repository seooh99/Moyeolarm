import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/user/view/set_nickname.dart';
import 'package:youngjun/user/viewmodel/auth_view_model.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});
  static var storage = const FlutterSecureStorage();

  Future isLogin() async {
    var resposne = await storage.read(key: "userInfo");
    var info = jsonDecode(resposne!);
    return info.nickname ? true : false;
  }

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
                AuthViewModel();
                dynamic info = isLogin();
                if (info == true) {
                  // Navigator.push(context, (context)=> MainPage());
                } else {
                  print("$info 12355");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SetNickname()));
                }
                // var storage = const FlutterSecureStorage();
              },
            ),
          ),
        ],
      ),
      backgroundColor: BACKGROUND_COLOR,
    );
  }
}


// class LoginView extends ConsumerWidget {
//   const LoginView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // User user = ref.watch(userProvider);
//     // AsyncValue<User> config = ref.watch(configProvider);
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const SizedBox(
//             width: 200,
//             height: 120,
//           ),
//           Center(
//             child: Container(
//               color: Colors.red,
//               width: 280,
//               height: 280,
//             ),
//           ),
//           const SizedBox(
//             width: 200,
//             height: 120,
//           ),
//           Center(
//             child: InkWell(
//               child: Image.asset(
//                 'assets/images/kakao_login_medium_wide.png',
//               ),
//               onTap: () {
//                 return config.when(
//                   error: (error, stack) {
//                     print("Error: $error");
//                     Text('Error: $error');
//                   },
//                   loading: () {
//                     print("loading...");
//                     const CircularProgressIndicator();
//                   },
//                   data: (config) {
//                     if (config.nickname == null) {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const SetNickname()));
//                     } else if (config.nickname != null) {
//                       print(config.nickname);
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //         builder: (context) => const MainPage()));
//                     }
//                   },
//                 );
//               },

//               // onTap: () async {
//               //   var isLogin = await UserViewModel().login();

//               //   print("카카오 로그인");
//               //   print(isLogin.toString());
//               //   print("${ref.read(userProvider.notifier).state.nickname} 왜 안돼");
//               //   if (isLogin.toString() == "main") {
//               //     print("go main page");
//               //     // Navigator.push(context, MaterialPageRoute(builder: Main()));
//               //   } else if (isLogin.toString() == "signin") {
//               //     print("go signin page");
//               //     Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //             builder: (context) => const SetNickname()));
//               //   }
//               //   // var usrNickname = Provider((ref) {
//               //   //   var usr = ref.watch(userProvider);
//               //   //   return usr;
//               //   // });
//               //   // print((usrNickname));
//               //   // UserViewModel();
//               //   // print("$userList");
//               //   // Navigator.push(
//               //   //   context,
//               //   //   MaterialPageRoute(
//               //   //     builder: (context) => SetNickname(),
//               //   //   ),
//               //   // );
//               // },
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: BACKGROUND_COLOR,
//     );
//   }
// }
