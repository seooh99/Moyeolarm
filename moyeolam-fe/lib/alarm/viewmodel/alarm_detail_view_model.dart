import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moyeolam/alarm/model/alarm_detail_model.dart';
import 'package:moyeolam/alarm/repository/alarm_list_repository.dart';




// final alarmDetailProvider = FutureProvider((ref) async {
//     return await AlarmListDetailViewModel().getAlarmListDetail(AlarmListDetailViewModel().alarmGroupId);
//     // return await _alarmListRepository.getAlarmListDetail(AlarmListDetailViewModel().alarmGroupId);;
//   }
// );
AlarmListDetailViewModel alarmListDetailViewModel = AlarmListDetailViewModel();
final alarmDetailProvider = ChangeNotifierProvider((ref)  {
    return alarmListDetailViewModel;
  }
);

final alarmDetailFutureProvider = FutureProvider((ref) async {
  return await alarmListDetailViewModel.getAlarmListDetail();
});

class AlarmListDetailViewModel extends ChangeNotifier{
  late int alarmGroupId;
  static final AlarmListRepository _alarmListRepository = AlarmListRepository();
  // setGroupId(int id){
  //   groupId = id;
  //   print("set id in listDetail id is $id");
  // }

  setAlarmGroupId(int newAlarmGroupId){
    alarmGroupId = newAlarmGroupId;
    // print("update alarmGroupId: $alarmGroupId");
    notifyListeners();
  }

  Future<AlarmGroup?> getAlarmListDetail() async {
    var response = await _alarmListRepository.getAlarmListDetail(alarmGroupId);
    // print("${response.code} hi");
    if (response.code == "200"){
      // print("rehi");
      return response.data.alarmGroup;
    }
    return null;
  }
  kickFriend(int alarmGroupId, int memberId) async {
    var response = await _alarmListRepository.kickFriend(alarmGroupId, memberId);
    if (response.code == "200"){
      return response.data;
    }
  }
}