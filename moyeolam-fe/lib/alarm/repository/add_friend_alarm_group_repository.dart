import 'package:dio/dio.dart';
import 'package:youngjun/alarm/data_source/add_friend_alarm_group_data_source.dart';
import 'package:youngjun/alarm/model/add_friend_alarm_group_model.dart';
import 'package:youngjun/common/const/address_config.dart';

class AddFriendAlarmGroupRepository {
  final AddFriendAlarmGroupDataSource _addFriendAlarmGroupDataSource = AddFriendAlarmGroupDataSource(
    Dio(),
    baseUrl: BASE_URL,
  );

  Future<AddFriendAlarmGroupResponseModel> inviteFriend(int alarmGroupId, List<int?> memberIds){
    var params = AddFriendAlarmGroupRequestModel(memberIds: memberIds);
    print("Check Params Invite Friend : ${params.memberIds}");
    return _addFriendAlarmGroupDataSource.addFriendAlarmGroup(alarmGroupId, params);
  }

}