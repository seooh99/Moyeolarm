import 'package:flutter/material.dart';

class BtnBack extends StatelessWidget {
  const BtnBack({super.key, required this.onPressed,});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // onPressed = enabled ? () {} : null;

    return IconButton(
              icon: const Icon(Icons.arrow_back_ios_new), onPressed: onPressed,
    );

  }
}
