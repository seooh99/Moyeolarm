import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';

import '../../common/const/alarm_list.dart';

class MainAlarmList extends StatefulWidget {
  const MainAlarmList({Key? key}) : super(key: key);

  @override
  _MainAlarmListState createState() => _MainAlarmListState();
}

class _MainAlarmListState extends State<MainAlarmList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main Setting page',
      home: Scaffold(
        backgroundColor: LIST_BLACK_COLOR,
        body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Column(
            children: [
              AlarmList(),
            ],
          ),
        ),
      ),
    );
  }
}
