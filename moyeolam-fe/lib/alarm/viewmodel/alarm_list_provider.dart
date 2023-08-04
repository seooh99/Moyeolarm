import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/model/alarm_list_model.dart';
import 'package:youngjun/alarm/repository/alarm_list_repository.dart';
import 'package:youngjun/common/const/address_config.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:dio/dio.dart';

Dio dio = Dio();
AlarmListRepository _alarmListRepository = AlarmListRepository(dio, baseUrl: BASE_URL);

final dioProvider =FutureProvider<Dio>((ref) {

  final dio = Dio();

  final storage =ref.watch(secureStorageProvider);

  return dio;
});

final alarmListProvider =
StateNotifierProvider<AlarmListNotifier, List<AlarmListModel>>((ref) {

  _alarmListRepository.getAlarmList();

  final repository =ref.watch(alarmRepositoryProvider);

  final notifier = AlarmListNotifier(repository: repository);

  return notifier;

});

class AlarmListNotifier extends StateNotifier<List<AlarmListModel>> {

  final AlarmListRepository repository;

  AlarmListNotifier({required this.repository}) : super([]);


  void addAlarm(AlarmListModel alarm) {
    state = [...state, alarm];
  }


  void removeAlarm(int alarmGroupId) {
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
