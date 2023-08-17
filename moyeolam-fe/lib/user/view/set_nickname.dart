import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/background_alarm/view/alarm_observer.dart';
import 'package:youngjun/background_alarm/view/home_screen.dart';
import 'package:youngjun/background_alarm/view/permission_request_screen.dart';
import 'package:youngjun/common/button/btn_call.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/layout/title_bar.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:youngjun/common/textfield_bar.dart';
import 'package:youngjun/main.dart';
import 'package:youngjun/main/view/main_page.dart';
import 'package:youngjun/user/model/user_model.dart';
import 'package:youngjun/user/viewmodel/set_nickname_view_model.dart';

class SetNickname extends StatefulWidget {
  const SetNickname({super.key});

  @override
  State<SetNickname> createState() => _SetNicknameState();
}

class _SetNicknameState extends State<SetNickname> {
  NicknameViewModel nicknameViewModel = NicknameViewModel();
  final UserInformation _userInformation = UserInformation(storage);
  String? isOverlaped;
  TextEditingController _setNickname = TextEditingController();
  FocusNode textFocus = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    _setNickname.dispose();
    textFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final nickname = ref.watch(nicknameProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: TitleBar(appBar: AppBar(), title: "닉네임 설정"),
        body: SafeArea(
          child: GestureDetector(
            onTap: (){
              textFocus.unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   width: 200,
                  //   height: 120,
                  //   child: Text(NicknameViewModel().nName),
                  // ),
                  Container(
                    margin: EdgeInsets.only(left: 8, right: 8, top: 20),
                    padding: EdgeInsets.all(8),
                    child: TextFieldbox(
                      textFocus: textFocus,
                      controller: _setNickname,
                      setContents: (String  value){
                        // nicknameViewModel.setNickname(value);
                      },
                      onSubmit: (String value) async{
                        nicknameViewModel.setNickname(value);
                        if (nicknameViewModel.nName == ''){
                          setState(() {
                            isOverlaped = "닉네임을 입력해주세요.";
                          });
                        }else {
                          var code = await nicknameViewModel.apiNickname();
                          // print("$code 닉네임 뷰 코드");
                          if (code == "603") {
                            setState(() {
                              isOverlaped = "이미 사용된 닉네임 입니다.";
                            });
                            // print("$isOverlaped 오버랩");
                          } else if (code == "200") {
                            UserModel? userInfo =
                                await _userInformation.getUserInfo();
                            if (userInfo != null) {
                              userInfo.nickname = nicknameViewModel.nName;
                              await _userInformation.setUserInfo(userInfo);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                              MainPage()));
                                          // PermissionRequestScreen(
                                          //     child: AlarmObserver(
                                          //         child: MainPage()))));
                            }
                          }
                        }
                        textFocus.unfocus();
                      },
                    ),
                  ),
                  Text(isOverlaped??'',
                  style:const TextStyle(
                    fontSize: 16,
                    color: FONT_COLOR,
                  ),

                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(
                    width: 200,
                    height: 360,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    child: Center(
                        child: BtnCalling(
                          onPressed: () async {
                            // print("닉네임 설정 뷰");
                            try {
                              if (nicknameViewModel.nName == ''){
                                setState(() {
                                  isOverlaped = "닉네임을 입력해주세요.";
                                });
                              }else {
                                var code = await nicknameViewModel.apiNickname();
                                // print("$code 닉네임 뷰 코드");
                                if (code == "603") {
                                  setState(() {
                                    isOverlaped = "이미 사용된 닉네임 입니다.";
                                  });
                                  // print("$isOverlaped 오버랩");
                                } else if (code == "200") {
                                  UserModel? userInfo =
                                  await _userInformation.getUserInfo();
                                  if (userInfo != null) {
                                    userInfo.nickname = nicknameViewModel.nName;
                                    await _userInformation.setUserInfo(userInfo);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                    MainPage()));
                                                // PermissionRequestScreen(
                                                //     child: AlarmObserver(
                                                //         child: MainPage()))));
                                  }
                                }else{
                                  print("null NIckname");
                                }
                              }
                            } catch (e) {
                              print("setNicknameView error $e");
                            }
                          },
                          backGroundColor: MAIN_COLOR,
                          icons: Text("시작하기"),
                        )
                    //     ElevatedButton(
                    //   onPressed: () async {
                    //     print("닉네임 설정 뷰");
                    //     try {
                    //       if (nicknameViewModel.nName == ''){
                    //         setState(() {
                    //           isOverlaped = "닉네임을 입력해주세요.";
                    //         });
                    //       }else {
                    //         var code = await nicknameViewModel.apiNickname();
                    //         print("$code 닉네임 뷰 코드");
                    //         if (code == "603") {
                    //           setState(() {
                    //             isOverlaped = "이미 사용된 닉네임 입니다.";
                    //           });
                    //           print("$isOverlaped 오버랩");
                    //         } else if (code == "200") {
                    //           UserModel? userInfo =
                    //               await _userInformation.getUserInfo();
                    //           if (userInfo != null) {
                    //             userInfo.nickname = nicknameViewModel.nName;
                    //             await _userInformation.setUserInfo(userInfo);
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         PermissionRequestScreen(
                    //                             child: AlarmObserver(
                    //                                 child: MainPage()))));
                    //           }
                    //         }
                    //       }
                    //     } catch (e) {
                    //       print("setNicknameView error $e");
                    //     }
                    //   },
                    //   child: const Text("시작하기"),
                    // )
                      ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: BACKGROUND_COLOR,
      ),
    );
  }
}
