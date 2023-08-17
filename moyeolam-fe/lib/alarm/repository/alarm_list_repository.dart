import 'package:dio/dio.dart';
import 'package:moyeolam/alarm/data_source/alarm_detail_data_source.dart';
import 'package:moyeolam/alarm/model/delete_friend_alarm_group_model.dart';
import 'package:moyeolam/common/const/address_config.dart';
import 'package:moyeolam/common/secure_storage/secure_storage.dart';
import 'package:moyeolam/main.dart';
import 'package:moyeolam/user/model/user_model.dart';

import '../model/add_alarm_group_model.dart';
import '../model/alarm_detail_model.dart';
import '../model/alarm_list_model.dart';
import '../model/alarm_toggle_model.dart';

class AlarmListRepository {
  UserInformation _userInformation = UserInformation(storage);
  final AlarmListDataSource _alarmListDataSource = AlarmListDataSource(
    Dio(),
    baseUrl: BASE_URL,
  );

  Future<AlarmListResponseModel> getAlarmList() async{
    UserModel? userInfo = await _userInformation.getUserInfo();
    // print("${userInfo?.accessToken} userInfo");
    String token = "Bearer ${userInfo!.accessToken}";
    return _alarmListDataSource.getAlarmList(token);
  }

  Future<AlarmDetailResponseModel> getAlarmListDetail(int alarmGroupId) async {
    // print("alarmGroupId: ${alarmGroupId}");
    UserModel? userInfo = await _userInformation.getUserInfo();
    String token = "Bearer ${userInfo!.accessToken}";
    return _alarmListDataSource.getAlarmDetail(token, alarmGroupId);
  }

  Future<AddAlarmGroupResponseModel> deleteAlarmGroup(int alarmGroupId) async{
    // print("delete $alarmGroupId");
    UserModel? userInfo = await _userInformation.getUserInfo();
    // print("${userInfo?.accessToken} userInfo");
    String token = "Bearer ${userInfo!.accessToken}";
    return _alarmListDataSource.deleteAlarmGroup(token, alarmGroupId);
  }

  Future<AlarmToggleResponseModel> updateToggle(int alarmGroupId) async{
    // print("update Toggle $alarmGroupId");
    UserModel? userInfo = await _userInformation.getUserInfo();
    // print("${userInfo?.accessToken} userInfo");
    String token = "Bearer ${userInfo!.accessToken}";
    return _alarmListDataSource.updateToggle(token, alarmGroupId);
  }

  Future<AlarmGroupDeleteFriendResponseModel> kickFriend(int alarmGroupId, int memberId) async {
    // print("kickFriend: $alarmGroupId");
    UserModel? userInfo = await _userInformation.getUserInfo();
    // print("${userInfo?.accessToken} userInfo");
    String token = "Bearer ${userInfo!.accessToken}";
    AlarmGroupDeleteFriendRequestModel params = AlarmGroupDeleteFriendRequestModel(memberId: memberId);
    return await _alarmListDataSource.kickFriend(token, alarmGroupId, params);
  }
}