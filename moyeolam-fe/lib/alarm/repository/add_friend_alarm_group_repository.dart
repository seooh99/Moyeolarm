import 'package:dio/dio.dart';
import 'package:youngjun/alarm/data_source/add_friend_alarm_group_data_source.dart';
import 'package:youngjun/alarm/model/add_friend_alarm_group_model.dart';
import 'package:youngjun/common/const/address_config.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:youngjun/main.dart';
import 'package:youngjun/user/model/user_model.dart';

class AddFriendAlarmGroupRepository {
  final UserInformation _userInformation = UserInformation(storage);
  final AddFriendAlarmGroupDataSource _addFriendAlarmGroupDataSource = AddFriendAlarmGroupDataSource(
    Dio(),
    baseUrl: BASE_URL,
  );

  Future<AddFriendAlarmGroupResponseModel> inviteFriend(int alarmGroupId, List<int?> memberIds) async{
    var params = AddFriendAlarmGroupRequestModel(memberIds: memberIds);
    print("Check Params Invite Friend : ${params.memberIds}");
    print("Check alarmGroupId : ${alarmGroupId}");
    UserModel? userInfo = await _userInformation.getUserInfo();
    String token = "Bearer ${userInfo!.accessToken}";
    return _addFriendAlarmGroupDataSource.addFriendAlarmGroup(token, alarmGroupId, params);
  }

}