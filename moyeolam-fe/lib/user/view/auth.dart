import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:youngjun/user/model/user_model.dart';
import 'package:youngjun/user/repository/user_repository.dart';
import 'package:youngjun/user/view/set_nickname.dart';
import 'package:youngjun/user/viewmodel/auth_view_model.dart';

import '../../main/view/main_page.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  late UserInformation _userInformation;
  UserModel? userInfo;
  @override
  void initState() {
    // TODO: implement initState
    _userInformation = UserInformation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
    super.initState();
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    // userInfo = await storage.read(key: 'userInfo');
    userInfo= await _userInformation.getUserInfo();
    print("$userInfo 123");
    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (userInfo != null) {
      // Navigator.pushNamed(
      //     context,
      //     "/home");
      Navigator.of(context).push(MaterialPageRoute(
          builder:(context) => MainPage(), ));
    }
  }


  @override
  Widget build(BuildContext context) {
    AuthViewModel auth = AuthViewModel();
    return MaterialApp(
      home: Scaffold(
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
            // Container(
            //   child: FittedBox(
            //     child: Image.asset('assets/images/moyeolam_logo.png'),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            
            Center(
              child: Container(
                child: FittedBox(
                  child: Image.asset(
                    'assets/images/moyeolam.png',
                  ),
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
                  if (userInfo != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder:
                          (context) => MainPage(),
                      )
                    );
                  } else {
                    var isSigned = await auth.login();
                    print("$isSigned 나는 뷰");
                    if (isSigned == "main") {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder:
                              (context) => MainPage(),
                          )
                      );
                      // Navigator.pushNamed(context, "/home");
                    } else if (isSigned == "signin") {
                      // Navigator.pushNamed(context, "/set_nickname");
                      Navigator.of(context).push(
                          MaterialPageRoute(builder:
                              (context) => SetNickname(),
                          )
                      );
                    }
                  }
                  // var storage = const FlutterSecureStorage();
                },
              ),
            ),
          ],
        ),
        backgroundColor: BACKGROUND_COLOR,
      ),
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
