

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youngjun/alarm/model/alarm_detail_model.dart';
import 'package:youngjun/alarm/model/alarm_list_model.dart';
import 'package:youngjun/common/const/data.dart';

import '../../common/const/address_config.dart';

part 'alarm_detail_repository.g.dart';


final alarmDetailRepositoryProvider = Provider<AlarmDetailRepository>((ref){

  final dio = Dio();

  final repository = AlarmDetailRepository(dio, baseUrl: '$ip/alarmgroups/{alarmGroupId}');

  return repository;

});

@RestApi(baseUrl: BASE_URL)
abstract class AlarmDetailRepository {
  // http://$ip/restaurant
  factory AlarmDetailRepository(Dio dio, {String baseUrl}) =
  _AlarmDetailRepository;

  // http://$ip/restaurant/
  @GET('//alarmgroups/{alarmGroupId}')
  Future<AlarmDetailModel> getAlarmList({
    @Path() required String alarmGroupId,
  });
}