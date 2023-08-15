import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/background_alarm/view/alarm_observer.dart';
import 'package:youngjun/background_alarm/view/home_screen.dart';
import 'package:youngjun/background_alarm/view/permission_request_screen.dart';
import 'package:youngjun/common/const/colors.dart';
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
  @override

  @override
  Widget build(BuildContext context) {
    // final nickname = ref.watch(nicknameProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   width: 200,
              //   height: 120,
              //   child: Text(NicknameViewModel().nName),
              // ),
              TextFieldbox(
                setContents: nicknameViewModel.setNickname,
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
              Center(
                  child: ElevatedButton(
                onPressed: () async {
                  print("닉네임 설정 뷰");
                  try {
                    var code = await nicknameViewModel.apiNickname();
                    print("$code 닉네임 뷰 코드");
                    if (code == "603"){
                      setState(() {
                        isOverlaped = "이미 사용된 닉네임 입니다.";
                      });
                      print("$isOverlaped 오버랩");
                    }else if(code == "200") {
                      UserModel? userInfo = await _userInformation.getUserInfo();
                      if(userInfo != null) {
                        userInfo!.nickname = nicknameViewModel.nName;
                        await _userInformation.setUserInfo(userInfo);
                        // Navigator.of(context).pushNamed("/alarm");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => PermissionRequestScreen(child: AlarmObserver(child: MainPage()))));
                      }
                    }
                    //     .then((value) {
                    //         print("$value 닉네임 모델");
                    //   //       if (value == "false") {
                    //   //         setState(() {
                    //   //           overlaped = true;
                    //   //         });
                    //   // } else {
                    //   //   print("$value 닉네임 모델");
                    //   //
                    //   //   Navigator.pushNamed(context, "/main_alarm_list");
                    //   // }
                    //   print("nickname setting ok nicknameView");
                    // });
                  } catch (e) {
                    print("setNicknameView error $e");
                  }
                },
                child: const Text("시작하기"),
              )),
            ],
          ),
        ),
        backgroundColor: BACKGROUND_COLOR,
      ),
    );
  }
}
