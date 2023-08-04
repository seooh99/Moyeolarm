

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youngjun/alarm/model/alarm_list_model.dart';
import 'package:youngjun/alarm/viewmodel/alarm_list_provider.dart';
import 'package:youngjun/common/const/data.dart';

import '../../common/const/address_config.dart';

part 'alarm_list_repository.g.dart';


final alarmRepositoryProvider = Provider<AlarmListRepository>((ref){

  final dio = Dio();

  final repository = AlarmListRepository(dio, baseUrl: 'http://i9a502.p.ssafy.io:8080');

  return repository;

});

@RestApi(baseUrl: 'http://i9a502.p.ssafy.io:8080')
abstract class AlarmListRepository {
  // http://i9a502.p.ssafy.io:8080
  factory AlarmListRepository(Dio dio, {String baseUrl}) =
  _AlarmListRepository;

  //http://i9a502.p.ssafy.io:8080/alarmgroup
  @GET('/alarmgroups')
  Future<List<AlarmListModel>> getAlarmList(
  );
}