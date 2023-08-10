import 'package:dio/dio.dart';
import 'package:youngjun/alarm/data_source/alarm_detail_data_source.dart';
import 'package:youngjun/common/const/address_config.dart';

import '../model/add_alarm_group_model.dart';
import '../model/alarm_detail_model.dart';
import '../model/alarm_list_model.dart';

class AlarmListRepository {
  final AlarmListDataSource _alarmListDataSource = AlarmListDataSource(
    Dio(),
    baseUrl: BASE_URL,
  );

  Future<AlarmListResponseModel> getAlarmList() {
    return _alarmListDataSource.getAlarmList();
  }

  Future<AlarmDetailResponseModel> getAlarmListDetail(int alarmGroupId) {
    print("alarmGroupId: ${alarmGroupId}");
    return _alarmListDataSource.getAlarmDetail(alarmGroupId);
  }

  Future<AddAlarmGroupResponseModel> deleteAlarmGroup(int alarmGroupId){
    print("delete $alarmGroupId");
    return _alarmListDataSource.deleteAlarmGroup(alarmGroupId);
  }
}