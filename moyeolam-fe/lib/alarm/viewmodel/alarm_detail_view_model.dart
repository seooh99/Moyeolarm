import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/model/alarm_detail_model.dart';
import 'package:youngjun/alarm/repository/alarm_list_repository.dart';

AlarmListRepository _alarmListRepository = AlarmListRepository();

final alarmDetailProvider = FutureProvider<AlarmDetailModel>((ref) async {
  AlarmListDetailViewModel _AlarmListDetailViewModel = AlarmListDetailViewModel();
  return await _AlarmListDetailViewModel.getAlarmListDetail(1);
  // if (_AlarmListDetailViewModel.groupId != null){
  // return await _AlarmListDetailViewModel.getAlarmListDetail(_AlarmListDetailViewModel.groupId);
  // }else{
  //   print("_AlarmListDetailViewModel.groupId is ${_AlarmListDetailViewModel.groupId}");
  //   return ;
  // }

  // return await _alarmListRepository.getAlarmList().then((value) => value.data);
});

class AlarmListDetailViewModel{

  late int groupId;

  setGroupId(int id){
    groupId = id;
    print("set id in listDetail id is $id");
  }


  getAlarmListDetail(int alarmGroupId) async {
    var response = await _alarmListRepository.getAlarmListDetail(alarmGroupId);
    if (response.code == "200"){
      return response.data;
    }
    return ;
  }
}