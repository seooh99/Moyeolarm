import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';


class TextFieldbox extends StatelessWidget {
  const TextFieldbox({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 250,
      child: Center(
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: MAIN_COLOR), // borderColor 사용
            ),
            labelText: '제목',
          ),
        ),
      ),
    );
  }
}




