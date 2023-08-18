import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moyeolam/alarm/model/add_alarm_group_model.dart';
import 'package:moyeolam/alarm/repository/alarm_add_repository.dart';
import 'package:moyeolam/common/secure_storage/secure_storage.dart';
import 'package:moyeolam/main.dart';
import 'package:moyeolam/user/model/user_model.dart';


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
    print("제목을 바꿔 $title");
  }
  void defaultDayOfWeek(List<bool> defaultWeek){

      dayOfWeek = [...defaultWeek];
      print("default setting $dayOfWeek");

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

  updateAlarmGroup(int alarmGroupId) async {
    try{
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

        var response = await _addAlarmGroupRepository.updateAlarmGroup(
            alarmGroupId,
            title,
            time,
            weekDay,
            alarmSound,
            alarmMission);
        if (response.code == "200") {
          return response.data;
        }

      return ;
    }catch(error){
      print("Update alarm group viewModel Error: $error");
    }
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
            title,
            time,
            weekDay,
            alarmSound,
            alarmMission);
        if (response != null && response.code == "200") {
          return response.data;
        }

      return ;
    }catch(error){
      print("AddAlarmError: $error");
    }
  }
}
