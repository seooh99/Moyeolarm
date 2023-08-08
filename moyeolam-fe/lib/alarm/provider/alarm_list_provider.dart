import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/model/alarm_list_model.dart';

import '../repository/alarm_list_repository.dart';

final alarmListProvider = FutureProvider<List<AlarmGroups>?>((ref) async {
  final dio = Dio();
  final alarms = AlarmListRepository(dio);

  return await alarms.getAlarmList().then((value) => value.data.alarmGroups);
});
