import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:youngjun/alarm/model/add_alarm_group_model.dart';
import 'package:youngjun/alarm/repository/alarm_add_repository.dart';


List<String> week = ["월", "화", "수", "목", "금", "토", "일"];


class AddAlarmGroupViewModel{
  final AddAlarmGroupRepository _addAlarmGroupRepository = AddAlarmGroupRepository();
  String title = '';
  String time = DateFormat('HH:mm').format(DateTime.now());
  List<bool> dayOfWeek = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  String alarmSound = '기본 알림음';
  String alarmMission = "얼굴 인식";

  void setDefaultData(List<bool> newDayOfWeek, String newAlarmSound, String newAlarmMission ){
    dayOfWeek = newDayOfWeek;
    alarmSound = newAlarmSound;
    alarmMission = newAlarmMission;
  }

  void setTitle(String newTitle){
    title = newTitle;
    print(title);
  }

  void setDayOfWeek(int index){
    var newDayOfWeek = [...dayOfWeek];
    newDayOfWeek[index] = !dayOfWeek[index];
    dayOfWeek = [...newDayOfWeek];
    print(dayOfWeek);
  }
  void setTime(DateTime newTime){
    time = DateFormat('HH:mm').format(newTime);
    print("$time 타임!");
  }

  void setAlarmSound(String newAlarmSound){
    alarmSound = newAlarmSound;
  }
  void setAlarmMission(String newAlarmMission){
    alarmMission = newAlarmMission;
  }

  addAlarmGroup() async{
    try {
      print(dayOfWeek);
      List<String?> weekDay = [];
      for(int index=0;index<7;index++){
        print("${dayOfWeek[index]}");
        if(dayOfWeek[index]) {
          weekDay.add("${week[index]}요일");
        }
      }

      // for (int index=0; index<7;index++) {
      //   dayOfWeek[index]?weekDay.add(week[index]);
      // }
      print("$weekDay check weekDay");
      var response = await _addAlarmGroupRepository.addAlarmGroup(
          title, time, weekDay, alarmSound, alarmMission);
      if (response != null) {
        return response.data;
      }
    }catch(error){
      print("AddAlarmError: $error");
    }
  }
}
