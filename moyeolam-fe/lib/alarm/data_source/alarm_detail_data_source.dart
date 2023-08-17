import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:youngjun/alarm/model/alarm_list_model.dart';
import 'package:youngjun/alarm/model/delete_friend_alarm_group_model.dart';

import '../model/add_alarm_group_model.dart';
import '../model/alarm_detail_model.dart';
import '../model/alarm_toggle_model.dart';

part 'alarm_detail_data_source.g.dart';

@RestApi()
abstract class AlarmListDataSource {
  factory AlarmListDataSource(Dio dio, {String baseUrl}) = _AlarmListDataSource;

  @GET('/alarmgroups')
  Future<AlarmListResponseModel> getAlarmList(
      @Header('Authorization') String token,
      );

  @GET('/alarmgroups/{alarmGroupId}')
  Future<AlarmDetailResponseModel> getAlarmDetail(
      @Header('Authorization') String token,
      @Path("alarmGroupId") int alarmGroupId,
      );

  @DELETE("/alarmgroups/{alarmGroupId}")
  Future<AddAlarmGroupResponseModel> deleteAlarmGroup(
      @Header('Authorization') String token,
      @Path("alarmGroupId") int alarmGroupId,
      );

  @POST("/alarmgroups/{alarmGroupId}/toggle")
  Future<AlarmToggleResponseModel> updateToggle(
      @Header('Authorization') String token,
      @Path("alarmGroupId") int alarmGroupId,
    );
  // 친구 강퇴
  @POST("/alarmgroups/{alarmGroupId}/ban")
  Future<AlarmGroupDeleteFriendResponseModel> kickFriend(
      @Header('Authorization') String token,
      @Path("alarmGroupId") int alarmGroupId,
      @Body() AlarmGroupDeleteFriendRequestModel memberId,
    );
}