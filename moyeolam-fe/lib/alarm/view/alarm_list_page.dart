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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HideNavBar hiding = HideNavBar();

    AsyncValue<List<AlarmGroups>?> alarmgroups = ref.watch(alarmListProvider);
    print("테스트");

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: TitleBar(
        appBar: AppBar(),
        title: '모여람',
        actions: [Icon(Icons.alarm)],
        leading: null,
      ),
      body: alarmgroups.when(
          data: (data) {
            if (data != null) {
              return CustomScrollView(
                controller: hiding.controller,
                slivers: [
                  SliverList.builder(
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
                  ),
                ],
              // return ListView.builder(
              //   itemCount: data.length,
              //
              //   itemBuilder: (context, index) {
              //     AlarmGroups alarmGroup = data[index];
              //
              //     // Navigator.pushNamed(context, arguments: data[index].alarmGroupId, "/main_alarm_list");
              //     return AlarmList(
              //       alarmGroupId: alarmGroup.alarmGroupId!,
              //       hour: alarmGroup.hour!,
              //       minute: alarmGroup.minute!,
              //       toggle: alarmGroup.toggle!,
              //       title: alarmGroup.title!,
              //     );
              //   },
              );
            }
          },
          error: (error, stackTrace) {},
          loading: () {}),
      bottomSheet: ValueListenableBuilder(
        valueListenable: hiding.visible,
        builder: (context, bool value, child) => AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: value ? kBottomNavigationBarHeight : 0.0,
          child: Wrap(
            children: <Widget>[
              MainNav(),
            ],
          ),
        ),
      ),
    );
  }
}
