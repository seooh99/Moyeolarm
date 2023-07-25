import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';


class TextFieldbox extends StatefulWidget {
  const TextFieldbox({super.key});

  @override
  State<TextFieldbox> createState() => _TextFieldboxState();
}

class _TextFieldboxState extends State<TextFieldbox> {

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 250,
      child: Center(
        child: TextField(
          keyboardType: TextInputType.text,
          // obscureText: true,
          cursorColor: MAIN_COLOR,
          style: TextStyle( // TextField의 텍스트 스타일 설정
            color: MAIN_COLOR,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
             borderSide: BorderSide(color: MAIN_COLOR,
              width: 3.0,
              ),
              // borderRadius: BorderRadius.circular(5.0),// borderColor 사용
            ),
            enabledBorder: OutlineInputBorder( // 입력창이 선택되지 않았을 때의 border 설정 (optional)

              borderSide: BorderSide(
                color: MAIN_COLOR,
                width: 3.0,
              ),
            ),
            focusedBorder: OutlineInputBorder( // 입력창이 선택되었을 때의 border 설정 (optional)

              borderSide: BorderSide(
                color: MAIN_COLOR,
                width: 3.0,
              ),
            ),
            labelText: '제목입력',
            labelStyle: TextStyle( // label의 텍스트 스타일 설정
              color: MAIN_COLOR,
            ),
            alignLabelWithHint: true, // label을 TextField의 가운데로 이동

          ),


        ),
      ),
    );
  }
}




