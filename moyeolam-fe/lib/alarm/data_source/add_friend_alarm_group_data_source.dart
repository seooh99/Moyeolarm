import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:youngjun/alarm/model/add_friend_alarm_group_model.dart';



part 'add_friend_alarm_group_data_source.g.dart';

@RestApi()
abstract class AddFriendAlarmGroupDataSource {
  factory AddFriendAlarmGroupDataSource(Dio dio, {String baseUrl}) = _AddFriendAlarmGroupDataSource;
  
  @POST('/alarmgroups/{alarmGroupId}/request')
  Future<AddFriendAlarmGroupResponseModel> addFriendAlarmGroup(
      @Header('Authorization') String token,
      @Path("alarmGroupId") int alarmGroupId,
      @Body() AddFriendAlarmGroupRequestModel memberIds,
      );
}