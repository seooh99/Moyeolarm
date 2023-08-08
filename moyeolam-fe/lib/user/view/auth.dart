import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/user/repository/user_repository.dart';
import 'package:youngjun/user/viewmodel/auth_view_model.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  static FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    var userInfo = storage.read(key: "userInfo");
    if (userInfo != null) {
      //  메인페이지 이동
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthViewModel auth = AuthViewModel();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const SizedBox(
          //   width: 200,
          //   height: 120,
          // ),
          TextButton(
              onPressed: () {
                auth.signOut();
              },
              child: Text("SignOut")),
          TextButton(
              onPressed: () {
                auth.logOut();
              },
              child: Text("Logout")),
          Center(
            child: Container(
              child: Image.asset(
                'assets/images/moyeolam.png',
              ),
              // color: Colors.red,
              width: 240,
              height: 240,
            ),
          ),
          const SizedBox(
            width: 200,
            height: 36,
          ),
          const Text(
            "모여람",
            style: TextStyle(
              color: FONT_COLOR,
              fontSize: 72,
            ),
          ),
          const SizedBox(
            width: 200,
            height: 80,
          ),
          Center(
            child: InkWell(
              child: Image.asset(
                'assets/images/kakao_login_medium_wide.png',
              ),
              onTap: () async {
                var hi = auth.isLogin();
                print("hi");
                if (hi == true) {
                  Navigator.pushNamed(context, "main_alarm_list");
                } else {
                  var isSigned = await auth.login();
                  print("$isSigned 나는 뷰");
                  if (isSigned == "main") {
                    Navigator.pushNamed(context, "/main_alarm_list");
                  } else if (isSigned == "signin") {
                    Navigator.pushNamed(context, "/set_nickname");
                  }
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
