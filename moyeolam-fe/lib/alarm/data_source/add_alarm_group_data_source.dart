import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../model/add_alarm_group_model.dart';

part 'add_alarm_group_data_source.g.dart';

@RestApi()
abstract class AddAlarmDataSource {
  factory AddAlarmDataSource(Dio dio, {String baseUrl}) = _AddAlarmDataSource;

  // 전체 조회
  @POST("/alarmgroups")
  Future<AddAlarmGroupResponseModel> addAlarmGroup(
      @Header('Authorization') String token,
      @Body() AddAlarmGroupRequestModel alarmGroup,
      );
  // 알람 수정
  @PATCH("/alarmgroups/{alarmGroupId}")
  Future<AddAlarmGroupResponseModel> updateAlarmGroup(
    @Header('Authorization') String token,
    @Path("alarmGroupId") int alarmGroupId,
    @Body() AddAlarmGroupRequestModel alarmGroup,
  );

  // 알람 토글 설정



}