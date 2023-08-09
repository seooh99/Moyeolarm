import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/model/alarm_detail_model.dart';
import 'package:youngjun/alarm/repository/alarm_list_repository.dart';

AlarmListRepository _alarmListRepository = AlarmListRepository();

// final alarmDetailProvider = FutureProvider<AlarmDetailModel>((ref) async {
//   AlarmListDetailViewModel _AlarmListDetailViewModel = AlarmListDetailViewModel();
//   // return await _AlarmListDetailViewModel.getAlarmListDetail();
//   // if (_AlarmListDetailViewModel.groupId != null){
//   // print("_AlarmListDetailViewModel.groupId is ${_AlarmListDetailViewModel.groupId}");
//   return await _AlarmListDetailViewModel.getAlarmListDetail(_AlarmListDetailViewModel.groupId);
//   // }else{
//   // }
//
//   // return await _alarmListRepository.getAlarmList().then((value) => value.data);
// });

class AlarmListDetailViewModel{

  // setGroupId(int id){
  //   groupId = id;
  //   print("set id in listDetail id is $id");
  // }


  getAlarmListDetail(int groupId) async {
    var response = await _alarmListRepository.getAlarmListDetail(groupId);
    // print("${response.code} hi");
    if (response.code == "200"){
      // print("rehi");
      return response.data.alarmGroup;
    }
    return ;
  }
}