import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:youngjun/alarm/model/alarm_list_model.dart';

import '../model/alarm_detail_model.dart';

part 'alarm_detail_data_source.g.dart';

@RestApi()
abstract class AlarmListDataSource {
  factory AlarmListDataSource(Dio dio, {String baseUrl}) = _AlarmListDataSource;

  @GET('/alarmgroups')
  Future<AlarmListResponseModel> getAlarmList();

  @GET('/alarmgroups/{alarmGroupId}')
  Future<AlarmDetailResponseModel> getAlarmDetail(
      @Path("alarmGroupId") int alarmGroupId,
      );
}