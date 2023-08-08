import 'package:flutter/material.dart';
import 'package:youngjun/common/clock.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/layout/title_bar.dart';

import '../../common/button/btn_save_update.dart';
import '../component/alarm_middle_select.dart';
import '../../common/textfield_bar.dart';
import 'alarm_list_page.dart';

class AlarmAddScreen extends StatefulWidget {
  const AlarmAddScreen({super.key});

  @override
  State<AlarmAddScreen> createState() => _AlarmAddScreenState();
}

class _AlarmAddScreenState extends State<AlarmAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: TitleBar(
        appBar: AppBar(),
        title: '알람생성하기',
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MainAlarmList(),
                ),
              );
            },
            child: Text(
              '생성하기',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          )
        ],
        leading: null,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 24,
          ),
          Center(
            child: Container(
              width: 320,
              child: TextFieldbox(
                setContents: (String) {}, colors: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(
            height: 20,
          ),
          Clock(),
          SizedBox(
            height: 20,
          ),
          AlarmMiddleSelect(
            dayOfDay: '월 수 금',
            alarmSound: '희망♬',
            certification: '희망',
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 28, right: 28, left: 28),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: MAIN_COLOR,
            minimumSize: Size(10, 60),
          ),
          onPressed: () {},
          child: Text('저장',
              style: TextStyle(
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
