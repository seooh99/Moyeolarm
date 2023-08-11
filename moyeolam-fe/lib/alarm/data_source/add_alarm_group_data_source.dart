import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../model/add_alarm_group_model.dart';

part 'add_alarm_group_data_source.g.dart';

@RestApi()
abstract class AddAlarmDataSource {
  factory AddAlarmDataSource(Dio dio, {String baseUrl}) = _AddAlarmDataSource;

  @POST("/alarmgroups")
  Future<AddAlarmGroupResponseModel> addAlarmGroup(
      @Body() AddAlarmGroupRequestModel alarmGroup,
      );

  @PATCH("/alarmgroups/{alarmGroupId}")
  Future<AddAlarmGroupResponseModel> updateAlarmGroup(
    @Path("alarmGroupId") int alarmGroupId,
    @Body() AddAlarmGroupRequestModel alarmGroup,
  );
}