import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moyeolam/common/const/colors.dart';
import '../viewmodel/alarm_ring_view_model.dart';


class RealTimeClock extends StatelessWidget {
  // final TimeService _timeService = TimeService();
  final Stream<DateTime> streamMethod;
  final bool isTime;
  RealTimeClock({
    super.key,
    required this.streamMethod,
    required this.isTime,
});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<DateTime>(
      stream: streamMethod,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final currentTime = snapshot.data!;
          print(currentTime);
          final List<String> weekDays = [
            "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
          ];
          // final formattedTime = isTime?"${
          //     DateFormat('hh').format(DateTime(currentTime.hour))
          // }:${
          //     DateFormat('mm').format(DateTime(currentTime.minute))
          // }":"${
          //     DateFormat('MM').format(DateTime(currentTime.month))
          // }월 ${
          //     DateFormat('dd').format(DateTime(currentTime.day))
          // }일 ${weekDays[currentTime.weekday-1]}요일"
          //     ;
          final formattedTime = isTime?DateFormat('a hh:mm', "ko").format(DateTime.now()):DateFormat('MM월 dd일 E요일', 'ko').format(DateTime.now());

          return Text(
            formattedTime,
            style:  TextStyle(
              fontSize: isTime?52:20,
                color: FONT_COLOR,
                fontWeight: FontWeight.bold
            ),
          );
        } else {
          return Text(
            isTime?DateFormat('a hh:mm', "ko").format(DateTime.now()):DateFormat('MM월 dd일 E요일', 'ko').format(DateTime.now()),
            style:  TextStyle(fontSize: isTime?52:20, color: FONT_COLOR,fontWeight: FontWeight.bold),
          );
        }
      },
    ),
    );
  }
}