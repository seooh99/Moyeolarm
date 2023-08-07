import 'package:flutter/material.dart';

import '../../common/clock.dart';
import '../../common/const/colors.dart';
import '../../common/layout/alarm_middle_select.dart';
import '../../common/layout/title_bar.dart';

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
          onPressed: () {
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          },
          appBar: AppBar(),
          title: '싸피 끝나고 여행가즈아', titleIcon: null, actions: [],
        ),
        body: Column(
          children: [
            Clock(),

            SizedBox(
              height: 20,
            ),
            Text('참여목록',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),),
          ],
        ),
    );
  }
}
