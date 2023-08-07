import 'package:flutter/material.dart';
import 'package:youngjun/common/clock.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/layout/title_bar.dart';

import '../../common/button/btn_save_update.dart';
import '../../common/layout/alarm_middle_select.dart';
import '../../common/textfield_bar.dart';

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
        onPressed: () {},
        appBar: AppBar(),
        title: '알람생성하기', titleIcon: null, actions: [],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Center(child: TextFieldbox(setContents: (String ) {  },)),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: 16,
          ),
          Clock(),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
