import 'package:flutter/material.dart';


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
              textStyle: const TextStyle(
                  fontSize: 18,
              ),
            ),
            onPressed: onPressed,
            child: Text(text,
              style: const TextStyle(
                  fontSize: 18,
                  color:Colors.purple,
                ),
              ),




    );
  }
}
