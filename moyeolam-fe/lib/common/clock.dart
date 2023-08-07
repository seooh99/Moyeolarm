import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => ClockState();
}
class ClockState extends State<Clock> {
  DateTime time = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 22, 35);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: 150,

          child: CupertinoDatePicker(
            backgroundColor: Colors.white,
          initialDateTime: time,
          mode: CupertinoDatePickerMode.time,
          // use24hFormat: true,
          // minimumDate: DateTime.now()
          // This is called when the user changes the time.
          onDateTimeChanged: (DateTime newTime) {
            setState(() => time = newTime);
            print(time);
          },
          ),
        ),
      );
  }
}