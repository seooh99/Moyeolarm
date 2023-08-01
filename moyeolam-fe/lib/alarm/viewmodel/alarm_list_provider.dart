import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/model/alarm_list_model.dart';

final alarmListProvider =
    StateNotifierProvider<AlarmListNotifier, List<Alarm>>((ref) {
  return AlarmListNotifier();
});

class AlarmListNotifier extends StateNotifier<List<Alarm>> {
  AlarmListNotifier() : super([]);

  // 할 일 추가
  void addTodo(Alarm alarm) {
    state = [...state, alarm];
  }

  // 할 일 삭제
  void removeTodo(int alarmGroupId) {
    state = [
      for (final Alarm in state)
        if (Alarm.alarmGroupId != alarmGroupId) Alarm,
    ];
  }

  void changeToggle(int alarmGroupId) {
    state = state
        .map((e) => e.alarmGroupId == alarmGroupId
            ? Alarm(
                alarmGroupId: e.alarmGroupId,
                hour: e.hour,
                minute: e.minute,
                toggle: !e.toggle,
                title: e.title,
              )
            : e)
        .toList();
  }
}
