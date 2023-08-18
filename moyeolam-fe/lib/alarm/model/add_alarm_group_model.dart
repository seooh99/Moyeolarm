import 'package:json_annotation/json_annotation.dart';

part 'add_alarm_group_model.g.dart';

@JsonSerializable()
class AddAlarmGroupRequestModel{
  final String title;
  final String time;
  final List<String?> dayOfWeek;
  final String alarmSound;
  final String alarmMission;

  AddAlarmGroupRequestModel({
    required this.title,
    required this.time,
    required this.dayOfWeek,
    required this.alarmSound,
    required this.alarmMission,
});

  factory AddAlarmGroupRequestModel.fromJson(Map<String, dynamic> json) => _$AddAlarmGroupRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddAlarmGroupRequestModelToJson(this);
}

@JsonSerializable()
class AddAlarmGroupResponseModel{
  final String code;
  final String message;
  final int data;

  AddAlarmGroupResponseModel({
    required this.code,
    required this.message,
    required this.data,
});

  factory AddAlarmGroupResponseModel.fromJson(Map<String, dynamic> json) => _$AddAlarmGroupResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddAlarmGroupResponseModelToJson(this);
}