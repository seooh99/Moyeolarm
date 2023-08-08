import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/repository/alarm_detail_repository.dart';

import '../model/alarm_detail_model.dart';

final alarmGroupDetailProvider = FutureProvider<AlarmGroup?>((ref) async {
  final dio = Dio();
  final alarmGroupDetail = AlarmDetailRepository(dio);

  return await alarmGroupDetail.getAlarmGroupDetail(1).then((value) => value.data.alarmGroup);
});

// class AlarmGroupDetailProvider extends FutureProvider<AlarmGroupDetail>{
//   AlarmGroupDetailProvider(this.ref):super(AlarmGroupDetail());
//
// }