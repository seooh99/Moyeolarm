import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/model/alarm_detail_model.dart';
import 'package:youngjun/alarm/repository/alarm_detail_repository.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  final storage = ref.watch(secureStorageProvider);

  return dio;
});

class AlarmDetailNotifier extends StateNotifier<List<AlarmDetailModel>>{

  final AlarmDetailRepository repository;

  AlarmDetailNotifier({
    required this.repository
}) : super([]);

  void modifyAlarm(AlarmDetailModel alarm){
    state = [...state, alarm];
  }



}