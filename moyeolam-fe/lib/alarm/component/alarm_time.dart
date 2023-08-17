import 'package:flutter/material.dart';
import 'package:moyeolam/common/const/colors.dart';

class AlarmTime extends StatelessWidget {
  const AlarmTime({
    required this.hour,
    required this.minute,
    required this.ampm,
    super.key,
  });

  final int hour;
  final int minute ;
  final String ampm;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Text('$ampm $hour : $minute',
        textAlign: TextAlign.center,
        style: TextStyle(color: FONT_COLOR),),
      ),
    );
  }
}
