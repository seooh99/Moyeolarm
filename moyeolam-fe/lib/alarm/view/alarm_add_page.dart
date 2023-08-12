import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:youngjun/alarm/viewmodel/add_alarm_group_view_model.dart';
import 'package:youngjun/alarm/viewmodel/alarm_detail_view_model.dart';

import 'package:youngjun/alarm/component/alarm_middle_select.dart';
import 'package:youngjun/alarm/model/alarm_detail_model.dart';
import 'package:youngjun/alarm/view/alarm_detail_page.dart';



import 'package:youngjun/common/button/btn_back.dart';
import 'package:youngjun/common/clock.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/layout/title_bar.dart';
import 'package:youngjun/common/textfield_bar.dart';


class AlarmAddScreen extends ConsumerStatefulWidget {
  const AlarmAddScreen({super.key, this.detailAlarmGroup, });
  final AlarmGroup? detailAlarmGroup;
  @override
  ConsumerState<AlarmAddScreen> createState() => _AlarmAddScreenState();
}

class _AlarmAddScreenState extends ConsumerState<AlarmAddScreen> {
  late final AddAlarmGroupViewModel _addAlarmGroupViewModel;
  // final AlarmListDetailViewModel _alarmListDetailViewModel = AlarmListDetailViewModel();
  @override
  void initState() {
    // TODO: implement initState
    _addAlarmGroupViewModel = AddAlarmGroupViewModel();
    if(widget.detailAlarmGroup != null) {
      _addAlarmGroupViewModel.defaultDayOfWeek(
          widget.detailAlarmGroup!.dayOfWeek);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var _alarmDetail = ref.watch(alarmDetailProvider);
    return Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        appBar: TitleBar(
          appBar: AppBar(),
          title: widget.detailAlarmGroup==null?'알람 생성':"알람 수정",
          actions: [
            TextButton(
              onPressed: () async {
                print(widget.detailAlarmGroup?.alarmGroupId);
                if(widget.detailAlarmGroup != null){
                  await _addAlarmGroupViewModel.updateAlarmGroup(widget.detailAlarmGroup!.alarmGroupId);
                  // var response = await _alarmListDetailViewModel.getAlarmListDetail(widget.detailAlarmGroup!.alarmGroupId);
                  await _alarmDetail.setAlarmGroupId(widget.detailAlarmGroup!.alarmGroupId);
                  // if (response != null) {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) =>
                  //           AlarmDetailScreen()));
                  // }else{
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) =>
                  //           const AlarmDetailScreen()
                  //     )
                  //   );
                  Navigator.of(context).pop();
                  // }
                }else {
                  var newGroupId = await _addAlarmGroupViewModel.addAlarmGroup();
                  // var response = await _alarmListDetailViewModel.getAlarmListDetail(newGroupId);
                  await _alarmDetail.setAlarmGroupId(newGroupId);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          AlarmDetailScreen()));
                }

              },
              child: const Text(
                '저장',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          ],
          leading: BtnBack(
              onPressed: (){
                Navigator.of(context).pop();
              }
          ),
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
                  defualtText: widget.detailAlarmGroup?.title??"제목",
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
              timeSet: widget.detailAlarmGroup!=null?
              DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                widget.detailAlarmGroup!.hour,
                widget.detailAlarmGroup!.minute,
              ):
              DateTime.now(),
              onTimeChanged: _addAlarmGroupViewModel.setTime,
            ),
            SizedBox(
              height: 20,
            ),
            AlarmMiddleSelect(
                dayOfWeek: widget.detailAlarmGroup?.dayOfWeek,
                alarmSound: widget.detailAlarmGroup?.alarmSound,
                alarmMission: widget.detailAlarmGroup?.alarmMission,
              addAlarmGroupViewModel: _addAlarmGroupViewModel,
            ),
          ],
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
