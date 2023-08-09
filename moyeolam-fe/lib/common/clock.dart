import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/common/const/colors.dart';

class Clock extends StatefulWidget {

  DateTime timeSet;
  Clock({super.key,
    required this.timeSet,
  });

  @override
  State<Clock> createState() => ClockState();
}
class ClockState extends State<Clock> {
  // int _hour = widget.hour;
  // DateTime time = DateTime(
  //   DateTime.now().year,
  //   DateTime.now().month,
  //   DateTime.now().day,
  // widget.hour,
  //     widget.minute,
  // );

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          color: BACKGROUND_COLOR,
          height: 150,
          child: CupertinoDatePicker(

            backgroundColor: BACKGROUND_COLOR,
          initialDateTime: widget.timeSet,
          mode: CupertinoDatePickerMode.time,
          // use24hFormat: true,
          // minimumDate: DateTime.now()
          // This is called when the user changes the time.
          onDateTimeChanged: (DateTime newTime) {
            setState(() => widget.timeSet = newTime);
            print(widget.timeSet);
          },
          ),
        ),
      );
  }
}