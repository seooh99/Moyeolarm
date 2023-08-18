import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog(
      {super.key,
        required this.cancelOnPressed,
        required this.okOnPressed,
        required this.title,
        required this.content,
        required this.okTitle,
        required this.cancelTitle,
      });
  final VoidCallback cancelOnPressed;
  final VoidCallback okOnPressed;
  final String title;
  final String content;
  final String okTitle;
  final String cancelTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () => cancelOnPressed(),
          child: Text(cancelTitle),
        ),
        TextButton(
          onPressed: () => okOnPressed(),
          child: Text(okTitle),
        ),
      ],
    );
  }
}
