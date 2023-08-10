import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/viewmodel/add_alarm_group_view_model.dart';
import 'package:youngjun/alarm/viewmodel/alarm_list_view_model.dart';
import 'package:youngjun/common/clock.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/layout/title_bar.dart';
import 'package:youngjun/main/view/main_page.dart';

import '../../common/button/btn_save_update.dart';
import '../component/alarm_middle_select.dart';
import '../../common/textfield_bar.dart';
import 'alarm_list_page.dart';




class AlarmAddScreen extends StatefulWidget {
  const AlarmAddScreen({super.key, });

  @override
  State<AlarmAddScreen> createState() => _AlarmAddScreenState();
}

class _AlarmAddScreenState extends State<AlarmAddScreen> {
  final AddAlarmGroupViewModel _addAlarmGroupViewModel = AddAlarmGroupViewModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        appBar: TitleBar(
          appBar: AppBar(),
          title: '알람 생성',
          actions: [
            TextButton(
              onPressed: () async {
                await _addAlarmGroupViewModel.addAlarmGroup();

                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainPage()));

              },
              child: const Text(
                '저장',
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
                  setContents: (String) {
                    _addAlarmGroupViewModel.setTitle(String);
                  },
                  colors: Colors.black,
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
            Clock(
              timeSet: DateTime.now(),
              onTimeChanged: _addAlarmGroupViewModel.setTime,
            ),
            SizedBox(
              height: 20,
            ),
            AlarmMiddleSelect(
                // dayOfWeek: _addAlarmGroupViewModel.dayOfWeek,
                // alarmSound: _addAlarmGroupViewModel.alarmSound,
                // alarmMission: _addAlarmGroupViewModel.alarmMission,
              addAlarmGroupViewModel: _addAlarmGroupViewModel,
            ),
          ],
        ),

      ),
    );
  }
}


// class _ChecklistMenuDemoState extends State<_ChecklistMenuDemo>
//     with RestorationMixin {
//   final _RestorableCheckedValues _checkedValues = _RestorableCheckedValues()
//     ..check(CheckedValue.three);
//
//   @override
//   String get restorationId => 'checklist_menu_demo';
//
//   @override
//   void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//     registerForRestoration(_checkedValues, 'checked_values');
//   }
//
//   void showCheckedMenuSelections(BuildContext context, CheckedValue value) {
//     if (_checkedValues.isChecked(value)) {
//       setState(() {
//         _checkedValues.uncheck(value);
//       });
//     } else {
//       setState(() {
//         _checkedValues.check(value);
//       });
//     }
//
//     widget.showInSnackBar(
//       GalleryLocalizations.of(context)!.demoMenuChecked(
//         _checkedValues.checkedValuesToString(context),
//       ),
//     );
//   }
