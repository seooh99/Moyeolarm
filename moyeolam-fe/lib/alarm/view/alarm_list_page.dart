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

class MainAlarmList extends ConsumerWidget {
  final ScrollController controller = ScrollController();

  // late AlarmListRepository alarms;

  List<AlarmListModel> alarmList = <AlarmListModel>[];

  //
  // late AlarmListModel response;
  // bool isLoading = false;
  //
  // getAlarms() async {
  //   final dio = Dio();
  //   final alarms = AlarmListRepository(dio);
  //
  //   // print(alarms.getAlarmList())
  //
  //   await alarms.getAlarmList().then((value) {
  //     // response = value['data'] as AlarmListModel;
  //     // isLoading = true;
  //
  //     for (var o in value.data.alarmGroups) {
  //       print(o.alarmGroupId);
  //       print(o.title);
  //       print(o.hour);
  //       print(o.minute);
  //       print(o.dayOfWeek);
  //       print(o.toggle);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<AlarmGroups>?> alarmgroups = ref.watch(alarmListProvider);

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
      body: alarmgroups.when(
          data: (data) {
            if(data != null){
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                AlarmGroups alarmGroup = data[index];
                return AlarmList(
                  alarmGroupId: alarmGroup.alarmGroupId!,
                  hour: alarmGroup.hour!,
                  minute: alarmGroup.minute!,
                  toggle: alarmGroup.toggle!,
                  title: alarmGroup.title!,
                );
              },
            );}
          },
          error: (error, stackTrace) {},
          loading: () {}),
      bottomSheet: MainNav(),
    );
  }
}
