import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/textfield_bar.dart';
import 'package:youngjun/user/viewmodel/set_nickname_view_model.dart';

class SetNickname extends StatefulWidget {
  const SetNickname({super.key});

  @override
  State<SetNickname> createState() => _SetNicknameState();
}

class _SetNicknameState extends State<SetNickname> {
  

  @override
  Widget build(BuildContext context) {
    // final nickname = ref.watch(nicknameProvider);
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   width: 200,
            //   height: 120,
            //   child: Text(NicknameViewModel().nName),
            // ),
            TextFieldbox(
              setContents: NicknameViewModel().setNickname,
            ),
            const SizedBox(
              width: 200,
              height: 360,
            ),
            Center(
                child: ElevatedButton(
              onPressed: () {
                print("닉네임 설정 뷰");
                try {
                  NicknameViewModel().apiNickname();
                }catch(e){

                }
              },
              child: const Text("시작하기"),
            )),
          ],
        ),
        backgroundColor: BACKGROUND_COLOR,
      ),
    );
  }
}
