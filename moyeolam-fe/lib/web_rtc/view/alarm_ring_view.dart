import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youngjun/common/button/btn_call.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/web_rtc/view/real_time_view.dart';
import 'package:youngjun/web_rtc/viewmodel/alarm_ring_view_model.dart';

class AlarmRingView extends StatefulWidget {
  const AlarmRingView({super.key});

  @override
  State<AlarmRingView> createState() => _AlarmRingViewState();
}

class _AlarmRingViewState extends State<AlarmRingView> {
  TimeService _timeService = TimeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,

        children: <Widget>[
          // 날짜
          RealTimeClock(
              streamMethod: _timeService.currentDateStream(),
            isTime: false,
          ),
          // 시간
          RealTimeClock(
              streamMethod: _timeService.currentTimeStream(),
            isTime: true,
          ),
          const SizedBox(
            width: 200,
            height: 120,
          ),
          Container(
            width: 200,
            height: 200,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset("assets/gif/moyeolam.gif"),
            ),
          ),
          const SizedBox(
            width: 200,
            height: 120,
          ),
          BtnCalling(
            icons: Icon(Icons.call),
            onPressed: (){},
          ),
          const SizedBox(
            width: 200,
            height: 120,
          ),
        ],
      ),
    );
  }
}
