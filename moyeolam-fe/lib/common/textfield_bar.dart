import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';

class TextFieldbox extends StatefulWidget {
  final Function(String) setContents;
  final Color colors;
  final Widget? suffixIcon;
  final Color? suffixIconColor;



  const TextFieldbox({
    super.key,
    required this.setContents,
    required this.colors,
    this.suffixIcon,
    this.suffixIconColor,


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
            color: widget.colors,
            width: 3.0,
          ),
          // borderRadius: BorderRadius.circular(5.0),// borderColor 사용
        ),
        enabledBorder: OutlineInputBorder(
          // 입력창이 선택되지 않았을 때의 border 설정 (optional)

          borderSide: BorderSide(
            color: widget.colors,
            width: 3.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          // 입력창이 선택되었을 때의 border 설정 (optional)

          borderSide: BorderSide(
            color: widget.colors,
            width: 3.0,
          ),
        ),
        labelText: '제목입력',
        labelStyle: TextStyle(
          // label의 텍스트 스타일 설정
          color: widget.colors,
        ),
        alignLabelWithHint: true, // label을 TextField의 가운데로 이동
      ),
    );
  }
}
