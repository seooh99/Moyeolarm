

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youngjun/alarm/model/alarm_list_model.dart';
import 'package:youngjun/common/const/data.dart';

import '../../common/const/address_config.dart';

part 'alarm_list_repository.g.dart';


// final alarmRepositoryProvider = Provider<AlarmListRepository>((ref){
//
//   final dio = Dio();
//
//   final repository = AlarmListRepository(dio, baseUrl: '$BASE_URL/alarmgroups');
//
//   return repository;
//
// });

@RestApi(baseUrl: BASE_URL)
abstract class AlarmListRepository {
  factory AlarmListRepository(Dio dio, {String baseUrl}) =
  _AlarmListRepository;

  @GET('/alarmgroups')
  Future<AlarmListModel> getAlarmList();


}