import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/model/alarm_list_model.dart';
import 'package:youngjun/alarm/repository/alarm_list_repository.dart';
import 'package:youngjun/common/const/address_config.dart';

// Dio dio = Dio();
// AlarmListRepository _alarmListRepository = AlarmListRepository(dio ,baseUrl: BASE_URL);

final dioProvider = Provider((ref) => Dio()); // Create a Dio instance

final _alarmListRepositoryProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return AlarmListRepository(dio);
});

final alarmListProvider = FutureProvider<AlarmListModel>((ref) async {
  final apiService = ref.read(_alarmListRepositoryProvider);
  final response = await apiService.getAlarmList();
  return response;
});