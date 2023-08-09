import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';

class TextFieldbox extends StatefulWidget {
  final Function(String) setContents;
  final Color? colors;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final TextEditingController? controller;
  final String? hint;



  const TextFieldbox({
    super.key,
    required this.setContents,
    this.colors,
    this.suffixIcon,
    this.suffixIconColor,
    this.controller,
    this.hint


  });

  @override
  State<TextFieldbox> createState() => _TextFieldboxState();
}

class _TextFieldboxState extends State<TextFieldbox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        widget.setContents(text);
      },
      keyboardType: TextInputType.text,
      // obscureText: true,
      cursorColor: MAIN_COLOR,
      style: const TextStyle(
        // TextField의 텍스트 스타일 설정
        color: MAIN_COLOR,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: MAIN_COLOR,
            width: 3.0,
          ),
          // borderRadius: BorderRadius.circular(5.0),// borderColor 사용
        ),
        enabledBorder: OutlineInputBorder(
          // 입력창이 선택되지 않았을 때의 border 설정 (optional)

          borderSide: BorderSide(
            color: MAIN_COLOR,
            width: 3.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          // 입력창이 선택되었을 때의 border 설정 (optional)

          borderSide: BorderSide(
            color: MAIN_COLOR,
            width: 3.0,
          ),
        ),
        labelText: '입력하세요',
        labelStyle: TextStyle(
          // label의 텍스트 스타일 설정
          color: MAIN_COLOR,
        ),
        alignLabelWithHint: true, // label을 TextField의 가운데로 이동
      ),
    );
  }
}
