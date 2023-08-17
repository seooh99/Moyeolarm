import 'package:flutter/material.dart';
import 'package:moyeolam/common/const/colors.dart';


class BtnSaveUpdate extends StatelessWidget {
  const BtnSaveUpdate({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // onPressed = enabled ? () {} : null;

    return TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.only(right: 8),
              textStyle: const TextStyle(
                  fontSize: 18,
              ),
            ),
            onPressed: onPressed,
            child: Text(text,
              style: const TextStyle(
                  fontSize: 18,
                  color:MAIN_COLOR,
                ),
              ),




    );
  }
}
