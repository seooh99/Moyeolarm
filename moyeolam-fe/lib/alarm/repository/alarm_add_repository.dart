import 'package:dio/dio.dart';
import 'package:moyeolam/alarm/data_source/add_alarm_group_data_source.dart';
import 'package:moyeolam/common/const/address_config.dart';
import 'package:moyeolam/common/secure_storage/secure_storage.dart';
import 'package:moyeolam/main.dart';
import 'package:moyeolam/user/model/user_model.dart';

import '../model/add_alarm_group_model.dart';

class AddAlarmGroupRepository {
  final AddAlarmDataSource _addAlarmDataSource = AddAlarmDataSource(
    Dio(),
    baseUrl: BASE_URL,
  );
  UserInformation _userInformation = UserInformation(storage);
  Future<AddAlarmGroupResponseModel> addAlarmGroup(String title, String time, List<String?> dayOfWeek, String alarmSound, String alarmMission) async{
    AddAlarmGroupRequestModel params = AddAlarmGroupRequestModel(
        title: title,
        time: time,
        dayOfWeek: dayOfWeek,
        alarmSound: alarmSound,
        alarmMission: alarmMission,
    );
    // print("title: ${params.title}");
    // print("time: ${params.time}");
    // print("dayOfWeek: ${params.dayOfWeek}");
    // print("alarmSound: ${params.alarmSound}");
    // print("alarmMission: ${params.alarmMission}");
    UserModel? userInfo = await _userInformation.getUserInfo();
    // print("${userInfo?.accessToken} userInfo");
    String token = "Bearer ${userInfo!.accessToken}";
    return _addAlarmDataSource.addAlarmGroup(token, params);
  }

  Future<AddAlarmGroupResponseModel> updateAlarmGroup(int alarmGroupId, String title, String time, List<String?> dayOfWeek, String alarmSound, String alarmMission) async{
    AddAlarmGroupRequestModel params = AddAlarmGroupRequestModel(
      title: title,
      time: time,
      dayOfWeek: dayOfWeek,
      alarmSound: alarmSound,
      alarmMission: alarmMission,
    );
    // print("title: ${params.title}");
    // print("time: ${params.time}");
    // print("dayOfWeek: ${params.dayOfWeek}");
    // print("alarmSound: ${params.alarmSound}");
    // print("alarmMission: ${params.alarmMission}");
    UserModel? userInfo = await _userInformation.getUserInfo();
    print("${userInfo?.accessToken} userInfo");
    String token = "Bearer ${userInfo!.accessToken}";
    return _addAlarmDataSource.updateAlarmGroup(token, alarmGroupId, params);
  }

}