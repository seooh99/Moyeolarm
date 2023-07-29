import 'package:flutter/material.dart';

class DialogExample extends StatelessWidget {
  const DialogExample(
      {super.key, required this.cancelOnPressed, required this.okOnPressed});
  final VoidCallback cancelOnPressed;
  final VoidCallback okOnPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: const Text('AlertDialog description'),
      actions: <Widget>[
        TextButton(
          onPressed: () => cancelOnPressed(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => okOnPressed(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
