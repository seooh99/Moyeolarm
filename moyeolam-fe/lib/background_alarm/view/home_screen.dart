import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/background_alarm/model/alarm.dart';
import 'package:youngjun/background_alarm/provider/alarm_list_provider.dart';
import 'package:youngjun/background_alarm/provider/alarm_state.dart';
import 'package:youngjun/background_alarm/service/alarm_polling_worker.dart';
import 'package:youngjun/background_alarm/service/alarm_scheduler.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _createAlarm(BuildContext context, AlarmListNotifier alarmListNotifier) async {
    final time = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 8, minute: 30));
    if (time == null) return;

    final alarm = Alarm(
      alarmGroupId: 1,
      callbackId: alarmListNotifier.getAvailableAlarmId(),
      weekday: [],
      hour: time.hour,
      minute: time.minute,
      toggle: true,
    );

    alarmListNotifier.add(alarm);
    await AlarmScheduler.scheduleRepeatable(alarm);
  }

  void _switchAlarm(AlarmListNotifier alarmListProvider, Alarm alarm, bool toggle) async {
    final newAlarm = alarm.copyWith(toggle: toggle);
    alarmListProvider.replace(
      alarm,
      newAlarm,
    );
    if (toggle) {
      await AlarmScheduler.scheduleRepeatable(newAlarm);
    } else {
      await AlarmScheduler.cancelRepeatable(newAlarm);
    }
  }

  void _handleCardTap(AlarmListNotifier alarmList,
      Alarm alarm,
      BuildContext context,
      ) async {
    final time = await showTimePicker(
      context: context,
      initialTime: alarm.timeOfDay,
    );
    if (time == null) return;

    final newAlarm = alarm.copyWith(hour: time.hour, minute: time.minute);

    alarmList.replace(alarm, newAlarm);
    if (alarm.toggle) await AlarmScheduler.cancelRepeatable(alarm);
    if (newAlarm.toggle) await AlarmScheduler.scheduleRepeatable(newAlarm);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, child){
      List<Alarm> alarms = ref.watch(alarmSettingProvider);
      AlarmListNotifier alarmListNotifier = ref.watch(alarmSettingProvider.notifier);

      int? callbackAlarmId = ref.watch(alarmStateProvider);
      AlarmState alarmState = ref.watch(alarmStateProvider.notifier);
      AlarmPollingWorker().createPollingWorker(alarmState);

      return Scaffold(
        appBar: AppBar(title: const Text('Flutter Alarm App')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _createAlarm(context, alarmListNotifier);
          },
          child: const Icon(Icons.add),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) => ListView.builder(
                    itemCount: alarmListNotifier.length,
                    itemBuilder: (context, index) {
                      final alarm = alarmListNotifier[index];
                      return _AlarmCard(
                        alarm: alarm,
                        onTapSwitch: (enabled) {
                          _switchAlarm(alarmListNotifier, alarm, enabled);
                        },
                        onTapCard: () {
                          _handleCardTap(alarmListNotifier, alarm, context);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _AlarmCard extends StatelessWidget {
  const _AlarmCard({
    Key? key,
    required this.alarm,
    required this.onTapSwitch,
    required this.onTapCard,
  }) : super(key: key);

  final Alarm alarm;
  final void Function(bool enabled) onTapSwitch;
  final VoidCallback onTapCard;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onTapCard,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  alarm.timeOfDay.format(context),
                  style: theme.textTheme.headline6!.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(
                      alarm.toggle ? 1.0 : 0.4,
                    ),
                  ),
                ),
              ),
              Switch(
                value: alarm.toggle,
                onChanged: onTapSwitch,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
