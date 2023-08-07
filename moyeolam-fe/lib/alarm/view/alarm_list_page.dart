import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/component/alarm_list.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/layout/main_nav.dart';
import 'package:youngjun/common/layout/title_bar.dart';

import '../model/alarm_list_model.dart';
import '../viewmodel/alarm_list_provider.dart';

class MainAlarmList extends ConsumerStatefulWidget {
  const MainAlarmList({super.key});

  @override
  ConsumerState<MainAlarmList> createState() => _MainAlarmListState();
}

class _MainAlarmListState extends ConsumerState<MainAlarmList> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<AlarmListModel> data = ref.watch(alarmListProvider);
    print(ref.read(alarmListProvider.notifier).toString());
    

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
      body: ListView(
        children: data
            .map(
              (e) => AlarmList(
                alarmGroupId: e.alarmGroupId,
                hour: e.hour,
                minute: e.minute,
                toggle: e.toggle,
                title: e.title,
              ),
            )
            .toList(),
      ),
      bottomSheet: MainNav(),
    );
  }
}
