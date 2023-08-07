import 'package:flutter/material.dart';

import '../../common/clock.dart';
import '../../common/const/colors.dart';
import '../../common/layout/title_bar.dart';
import '../component/alarm_guest_list.dart';
import '../component/alarm_middle_select.dart';
import 'alarm_list_page.dart';

class AlarmDetailScreen extends StatefulWidget {
  const AlarmDetailScreen({Key? key}) : super(key: key);

  @override
  State<AlarmDetailScreen> createState() => _AlarmDetailScreenState();
}

class _AlarmDetailScreenState extends State<AlarmDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        appBar: TitleBar(
          onPressed: () {},
          appBar: AppBar(),
          title: '싸피 끝나고 여행가즈아',
          titleIcon: null,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)
                    => MainAlarmList()));
              },
              child: Text('수정하기',
                style: TextStyle(
                  fontSize: 16,
                ),),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Clock(),
              SizedBox(
                height: 20,
              ),
              AlarmMiddleSelect(
                dayOfDay: '월, 수, 금',
                alarmSound: '희망',
                certification: '화상',
              ),
              Text(
                '참여목록',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              AlarmGuestList(nickname: '성공할췅년!', profileImage: Image.asset('assets/images/moyeolam.png'),),
            ],
          ),
        ));
  }
}
