// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:youngjun/alarm/model/alarm_list_model.dart';
// import 'package:youngjun/alarm/view/alarm_list_page.dart';
//
// import 'alarm_state.dart';
//
// class AlarmObserver extends StatefulWidget {
//   final Widget child;
//
//   AlarmObserver({
//     Key? key,
//     required this.child,
//   }) : super(key: key);
//
//   @override
//   _AlarmObserverState createState() => _AlarmObserverState();
// }
//
// class _AlarmObserverState extends State<AlarmObserver>
//     with WidgetsBindingObserver {
//
// //@@@@@@@@@
//
//   @override
//   Widget build(BuildContext context) {
//   return Consumer<AlarmState>(builder: (context, state, child) {
//   Widget? alarmScreen;
//
//   if (state.isFired) {
//   final callbackId = state.callbackAlarmId!;
//   AlarmListModel? alarm = context.read<AlarmListProvider>().getAlarmBy(callbackId);
//   if (alarm != null) {
//   alarmScreen = MainAlarmList();
//   }
//   }
//   return IndexedStack(
//   index: alarmScreen != null ? 0 : 1,
//   children: [
//   alarmScreen ?? Container(),
//   widget.child,
//   ],
//   );
//   });
//   }
// }