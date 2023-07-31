import 'package:flutter/material.dart';


class BtnSaveUpdate extends StatelessWidget {
  const BtnSaveUpdate({super.key, required this.onPressed,});

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
            child: const Text('저장',
              style: TextStyle(
                  fontSize: 18,
                  color:Colors.purple,
                ),
              ),




    );
  }
}
