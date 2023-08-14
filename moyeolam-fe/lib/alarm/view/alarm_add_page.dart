import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:youngjun/alarm/viewmodel/add_alarm_group_view_model.dart';
import 'package:youngjun/alarm/viewmodel/alarm_detail_view_model.dart';

import 'package:youngjun/alarm/component/alarm_middle_select.dart';
import 'package:youngjun/alarm/model/alarm_detail_model.dart';
import 'package:youngjun/alarm/view/alarm_detail_page.dart';
import 'package:youngjun/background_alarm/model/alarm.dart';
import 'package:youngjun/background_alarm/provider/alarm_list_provider.dart';
import 'package:youngjun/background_alarm/service/alarm_scheduler.dart';

import 'package:youngjun/common/button/btn_back.dart';
import 'package:youngjun/common/clock.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/layout/title_bar.dart';
import 'package:youngjun/common/textfield_bar.dart';

class AlarmAddScreen extends ConsumerStatefulWidget {
  const AlarmAddScreen({
    super.key,
    this.detailAlarmGroup,
  });

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
    if (widget.detailAlarmGroup != null) {
      _addAlarmGroupViewModel
          .defaultDayOfWeek(widget.detailAlarmGroup!.dayOfWeek);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _alarmDetail = ref.watch(alarmDetailProvider);
    AlarmListNotifier alarmListNotifier = ref.watch(alarmSettingProvider.notifier);

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: TitleBar(
        appBar: AppBar(),
        title: widget.detailAlarmGroup == null ? '알람 생성' : "알람 수정",
        actions: [
          TextButton(
            onPressed: () async {
              int? preHour = widget.detailAlarmGroup?.hour;
              int? preMinute = widget.detailAlarmGroup?.minute;
              List<bool>? preWeekday = widget.detailAlarmGroup?.dayOfWeek;

              print(widget.detailAlarmGroup?.alarmGroupId);
              if (widget.detailAlarmGroup != null) {
                await _addAlarmGroupViewModel
                    .updateAlarmGroup(widget.detailAlarmGroup!.alarmGroupId);
                // var response = await _alarmListDetailViewModel.getAlarmListDetail(widget.detailAlarmGroup!.alarmGroupId);
                await _alarmDetail
                    .setAlarmGroupId(widget.detailAlarmGroup!.alarmGroupId);
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

                // 알람 수정 시 알람 예약
                Alarm oldAlarm = Alarm(
                    alarmGroupId: _alarmDetail.alarmGroupId,
                    callbackId: _alarmDetail.alarmGroupId * 7,
                    hour: preHour!,
                    weekday: preWeekday!,
                    minute: preMinute!,
                    toggle: true); // 현재 토글값 가져와야함..

                int hour =
                    int.parse(_addAlarmGroupViewModel.time.split(":")[0]);
                int minute =
                    int.parse(_addAlarmGroupViewModel.time.split(":")[1]);

                oldAlarm.copyWith(hour: hour, minute: minute);

                Alarm newAlarm = Alarm(
                    alarmGroupId: _alarmDetail.alarmGroupId,
                    callbackId: _alarmDetail.alarmGroupId * 7,
                    weekday: _addAlarmGroupViewModel.dayOfWeek,
                    hour: hour,
                    minute: minute,
                    toggle: true); // 현재 토글값 가져와야함..

                alarmListNotifier.replace(oldAlarm, newAlarm);
                if (oldAlarm.toggle) await AlarmScheduler.cancelRepeatable(oldAlarm);
                if (newAlarm.toggle) await AlarmScheduler.scheduleRepeatable(newAlarm);


                Navigator.of(context).pop();
                // }
              } else {
                var newGroupId = await _addAlarmGroupViewModel.addAlarmGroup();
                // var response = await _alarmListDetailViewModel.getAlarmListDetail(newGroupId);
                await _alarmDetail.setAlarmGroupId(newGroupId);

                // 알람 새로 생성 시 알람 예약
                int hour =
                    int.parse(_addAlarmGroupViewModel.time.split(":")[0]);
                int minute =
                    int.parse(_addAlarmGroupViewModel.time.split(":")[1]);

                Alarm alarm = Alarm(
                    alarmGroupId: newGroupId,
                    callbackId: newGroupId * 7,
                    weekday: _addAlarmGroupViewModel.dayOfWeek,
                    hour: hour,
                    minute: minute,
                    toggle: true);
                alarmListNotifier.add(alarm);
                AlarmScheduler.scheduleRepeatable(alarm);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AlarmDetailScreen()));
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
        leading: BtnBack(onPressed: () {
          Navigator.of(context).pop();
        }),
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
                defualtText: widget.detailAlarmGroup?.title ?? "제목",
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
            timeSet: widget.detailAlarmGroup != null
                ? DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                    widget.detailAlarmGroup!.hour,
                    widget.detailAlarmGroup!.minute,
                  )
                : DateTime.now(),
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
