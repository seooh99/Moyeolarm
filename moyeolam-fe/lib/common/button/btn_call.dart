import 'package:flutter/material.dart';
import 'package:moyeolam/common/const/colors.dart';

class BtnCalling extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget icons;
  final Color? backGroundColor;
  const BtnCalling({
    super.key,
    this.onPressed,
    required this.icons,
    this.backGroundColor,
  });
  @override
  State<BtnCalling> createState() => _BtnCalling();
}

class _BtnCalling extends State<BtnCalling> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      minimumSize: Size(280, 40),
      backgroundColor: widget.backGroundColor ?? MAIN_COLOR,
    );

    return ElevatedButton(
          style: style,
          onPressed: widget.onPressed,
          child: widget.icons,
    );
  }
}
