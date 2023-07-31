import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/textfield_bar.dart';
import 'package:youngjun/common/button/btn_back.dart';

class SetNickname extends StatelessWidget {
  const SetNickname({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BtnBack(
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(
              width: 200,
              height: 120,
            ),
            Container(
              child: TextFieldbox(),
            ),
            const SizedBox(
              width: 200,
              height: 360,
            ),
            Center(
                child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("시작하기"),
            )),
          ],
        ),
        backgroundColor: BACKGROUND_COLOR,
      ),
    );
  }
}
