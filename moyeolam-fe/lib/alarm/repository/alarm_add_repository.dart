import 'package:dio/dio.dart';
import 'package:youngjun/alarm/data_source/add_alarm_group_data_source.dart';
import 'package:youngjun/common/const/address_config.dart';

import '../model/add_alarm_group_model.dart';

class AddAlarmGroupRepository {
  final AddAlarmDataSource _addAlarmDataSource = AddAlarmDataSource(
    Dio(),
    baseUrl: BASE_URL,
  );

  Future<AddAlarmGroupResponseModel> addAlarmGroup(String title, String time, List<String?> dayOfWeek, String alarmSound, String alarmMission){
    AddAlarmGroupRequestModel params = AddAlarmGroupRequestModel(
        title: title,
        time: time,
        dayOfWeek: dayOfWeek,
        alarmSound: alarmSound,
        alarmMission: alarmMission,
    );
    print("title: ${params.title}");
    print("time: ${params.time}");
    print("dayOfWeek: ${params.dayOfWeek}");
    print("alarmSound: ${params.alarmSound}");
    print("alarmMission: ${params.alarmMission}");
    return _addAlarmDataSource.addAlarmGroup(params);
  }

  Future<AddAlarmGroupResponseModel> updateAlarmGroup(int alarmGroupId, String title, String time, List<String?> dayOfWeek, String alarmSound, String alarmMission){
    AddAlarmGroupRequestModel params = AddAlarmGroupRequestModel(
      title: title,
      time: time,
      dayOfWeek: dayOfWeek,
      alarmSound: alarmSound,
      alarmMission: alarmMission,
    );
    print("title: ${params.title}");
    print("time: ${params.time}");
    print("dayOfWeek: ${params.dayOfWeek}");
    print("alarmSound: ${params.alarmSound}");
    print("alarmMission: ${params.alarmMission}");
    return _addAlarmDataSource.updateAlarmGroup(alarmGroupId, params);
  }

}