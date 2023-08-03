import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/textfield_bar.dart';
import 'package:youngjun/user/viewmodel/set_nickname_view_model.dart';

class SetNickname extends StatefulWidget {
  const SetNickname({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 120,
              child: Text(NicknameViewModel().nName),
            ),
            Container(
              child: const TextFieldbox(),
            ),
            const SizedBox(
              width: 200,
              height: 360,
            ),
            Center(
                child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("시작하기"),
            )),
          ],
        ),
        backgroundColor: BACKGROUND_COLOR,
      ),
    );
  }
}
