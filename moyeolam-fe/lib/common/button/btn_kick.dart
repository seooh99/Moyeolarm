import 'package:flutter/material.dart';


class BtnKick extends StatefulWidget {
  const BtnKick({super.key, required this.onPressed,});

  final VoidCallback onPressed;

  @override
  State<BtnKick> createState() => _IconButtonExampleState();
}

class _IconButtonExampleState extends State<BtnKick> {
  @override
  Widget build(BuildContext context) {
    return
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: widget.onPressed, // 'widget.' 추가
        );

  }
}
