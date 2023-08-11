
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/repository/alarm_list_repository.dart';

import '../model/alarm_list_model.dart';

AlarmListRepository _alarmListRepository = AlarmListRepository();

final alarmListProvider = FutureProvider<AlarmListModel>((ref) async {

  return await AlarmListViewModel().getAlarmList();
  // return await _alarmListRepository.getAlarmList().then((value) => value.data);
});

class AlarmListViewModel{
  getAlarmList() async {
    var response = await _alarmListRepository.getAlarmList();
    if (response.code == "200"){
      return response.data;
    }
  }

  deleteAlarmGroup(int alarmGroupId) async{
    var response = await _alarmListRepository.deleteAlarmGroup(alarmGroupId);
    if (response.code == '200'){
      return response.data;
    }
  }

  updateAlarmToggle(int alarmGroupId) async {
    var response = await _alarmListRepository.updateToggle(alarmGroupId);
    if (response.code == "200"){
      return response.data;
    }
  }
}