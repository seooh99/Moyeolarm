import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/component/alarm_list.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/layout/main_nav.dart';
import 'package:youngjun/common/layout/title_bar.dart';

import '../../common/const/address_config.dart';
import '../model/alarm_list_model.dart';
import '../repository/alarm_list_repository.dart';
import '../provider/alarm_list_provider.dart';

class MainAlarmList extends ConsumerStatefulWidget {
  const MainAlarmList({super.key});

  @override
  ConsumerState<MainAlarmList> createState() => _MainAlarmListState();
}

class _MainAlarmListState extends ConsumerState<MainAlarmList> {
  final ScrollController controller = ScrollController();
  // late AlarmListRepository alarms;

  List<AlarmListModel> _AlarmList = <AlarmListModel>[];

  late AlarmListModel response;
  bool isLoading = false;

  getAlarms() async {
    final dio = Dio();
    final alarms = AlarmListRepository(dio);

    // print(alarms.getAlarmList())

    await alarms.getAlarmList().then((value){
      // response = value['data'] as AlarmListModel;
      // isLoading = true;
      
        for (var o in value.data.alarmGroups) {
          print(o.alarmGroupId);
          print(o.title);
          print(o.hour);
          print(o.minute);
          print(o.dayOfWeek);
          print(o.toggle);
      }



    });
  }

  // @override
  // void initState()  {
  //   super.initState();

  // alarms.getAlarmList().then((value) {
  //   _AlarmList = value;

  // Dio dio = Dio();
  // alarms  = AlarmListRepository(dio, baseUrl: 'http://i9a502.p.ssafy.io:8080');
  //
  // final resp =  alarms.getAlarmList();
  //
  // print('$resp 제바랄ㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹ');

  // Future.microtask(() async {
  //   try {
  //     final resp = await alarms.getAlarmList();

  // print('${resp} ㅎㅎㅎ');

  //resp.forEach((alarm) {
  //print('Code: ${alarm.code}');
  //print('Message: ${alarm.message}');

  //if (alarm.data != null) {
  //  alarm.data!.alarmGroups.forEach((alarmGroup) {
  //    print('Alarm Group ID: ${alarmGroup.alarmGroupId}');
  //    print('Title: ${alarmGroup.title}');
  //    print('Hour: ${alarmGroup.hour}');
  //    print('Minute: ${alarmGroup.minute}');
  //    print('Day of Week: ${alarmGroup.dayOfWeek}');
  //    print('Is Lock: ${alarmGroup.isLock}');
  //    print('Toggle: ${alarmGroup.toggle}');
  //  });
  // }
  //});
  // } catch (e) {
  //   print('Error: $e');
  // }
  // });

  // late AlarmListModel response;
  // bool isLoading = false;
  //
  // getAlarmList(){
  //   final dio = Dio();
  //   final alarmList = AlarmListRepository(dio);
  //
  //   alarmList.getAlarmList().then((value){
  //     response = ((value['alarmGroups'] as List)[0]) as AlarmListModel;
  //     isLoading = true;
  //     log('${response.data.alarmGroups.title}' as num);
  //   });
  // }




  @override
  Widget build(BuildContext context) {

    final data =ref.watch(alarmListProvider);




    // final List<AlarmGroup> data = ref.watch(alarmListProvider);

    // print(data.toList());
    // print(alarms.getAlarmList());
    // print(_AlarmList);
    // print(alarms.getAlarmList().toString());
    //
    // alarms.getAlarmList().then((value) => print(value));

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: TitleBar(
        onPressed: () {
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@
        },
        appBar: AppBar(),
        title: '모여람',
        actions: [Icon(Icons.alarm)],
        titleIcon: null,
      ),
      body: ListView.builder(
        itemCount: _AlarmList.length,
        itemBuilder: (context, index) {
          AlarmListModel alarmGroup = _AlarmList[index];
          // return AlarmList(
          //
          //   alarmGroupId: data.value.,
          //   hour: alarmGroup.hour!,
          //   minute: alarmGroup.minute!,
          //   toggle: alarmGroup.toggle!,
          //   title: alarmGroup.title!,);
        },
      ),
      bottomSheet: MainNav(),
    );
  }
}
