import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/model/alarm_list_model.dart';
import 'package:youngjun/alarm/repository/alarm_list_repository.dart';
import 'package:youngjun/common/const/address_config.dart';

Dio dio = Dio();
AlarmListRepository _alarmListRepository = AlarmListRepository(dio ,baseUrl: BASE_URL);


final alarmListProvider =
    StateNotifierProvider<AlarmListNotifier, List<AlarmListModel>>((ref) {
  return AlarmListNotifier();
});

class AlarmListNotifier extends StateNotifier<List<AlarmListModel>> {
  AlarmListNotifier() : super([]);

  void getAlarmList(){
    _alarmListRepository.getAlarmList();
    print("알람 api 호출");
  }
  // 할 일 추가
  void addTodo(AlarmListModel alarm) {
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
            ? AlarmListModel(
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
