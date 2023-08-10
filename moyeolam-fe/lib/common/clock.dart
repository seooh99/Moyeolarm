import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/viewmodel/add_alarm_group_view_model.dart';
import 'package:youngjun/common/const/colors.dart';

class Clock extends StatefulWidget {
  final DateTime timeSet;
  final Function(DateTime) onTimeChanged; // 새로운 필드: 시간 설정 함수

  Clock({
    Key? key,
    required this.timeSet,
    required this.onTimeChanged, // 시간 설정 함수를 매개변수로 받음
  }) : super(key: key);

  @override
  State<Clock> createState() => ClockState();
}

class ClockState extends State<Clock> {
  late DateTime currentTime; // 현재 시간을 저장하는 변수

  @override
  void initState() {
    super.initState();
    currentTime = widget.timeSet; // 현재 시간을 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        color: BACKGROUND_COLOR,
        height: 150,
        child: CupertinoTheme(
          data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              dateTimePickerTextStyle: TextStyle(
                  color: FONT_COLOR,
                fontSize: 28
              ),
            )
          ),
          child: CupertinoDatePicker(
            backgroundColor: BACKGROUND_COLOR,
            initialDateTime: widget.timeSet,
            mode: CupertinoDatePickerMode.time,

            onDateTimeChanged: (DateTime newTime) {
              setState(() {
                currentTime = newTime; // 현재 시간 업데이트
              });
              widget.onTimeChanged(currentTime); // 외부 함수 호출하여 시간 업데이트 전달
            },
          ),
        ),
      ),
    );
  }
}
