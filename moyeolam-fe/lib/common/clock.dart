import 'package:flutter/cupertino.dart';

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({super.key});

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}
class _DatePickerExampleState extends State<DatePickerExample> {
  DateTime time = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 22, 35);

  @override
  Widget build(BuildContext context) {
    return
      CupertinoDatePicker(
      initialDateTime: time,
      mode: CupertinoDatePickerMode.time,
      // use24hFormat: true,
      // minimumDate: DateTime.now()
      // This is called when the user changes the time.
      onDateTimeChanged: (DateTime newTime) {
        var today_hour = DateTime.now().hour;
        var today_minute = DateTime.now().minute;
        var today_second = DateTime.now().second;
        if(newTime.hour < today_hour);
        else if(newTime.hour == today_hour);
        // else if();
        setState(() => time = newTime);
        print(time);
      },
      );
  }
}