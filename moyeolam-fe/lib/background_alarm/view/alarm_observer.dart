import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/background_alarm/model/alarm.dart';
import 'package:youngjun/background_alarm/provider/alarm_state.dart';
import 'package:youngjun/background_alarm/service/alarm_polling_worker.dart';
import 'package:youngjun/background_alarm/view/test_page.dart';

import '../provider/alarm_list_provider.dart';

class AlarmObserver extends ConsumerStatefulWidget {
  final Widget child;

  const AlarmObserver({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  ConsumerState<AlarmObserver> createState() => _AlarmObserverState();
}

class _AlarmObserverState extends ConsumerState<AlarmObserver> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        final _ = ref.watch(alarmStateProvider);
        final alarmState = ref.watch(alarmStateProvider.notifier);
        AlarmPollingWorker().createPollingWorker(alarmState);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      Widget? alarmScreen;
      Widget? testPage;
      final _ = ref.watch(alarmStateProvider);
      final state = ref.watch(alarmStateProvider.notifier);

      List<Alarm> alarms = ref.watch(alarmListProvider);
      AlarmListNotifier alarmListNotifier = ref.watch(alarmListProvider.notifier);

      if (state.isFired) {
        final callbackId = state.callbackAlarmId!;

        Alarm? alarm = alarmListNotifier.getAlarmBy(callbackId);
        if (alarm != null) {
          testPage = TestPage();
          // alarmScreen = AlarmScreen(alarm: alarm);
        }
      }
      return IndexedStack(
        index: testPage != null ? 0 : 1,
        children: [
          testPage ?? Container(),
          widget.child,
        ],
      );
    });
  }
}
