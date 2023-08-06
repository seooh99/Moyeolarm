import 'package:flutter/material.dart';
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
                print("1235");
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
