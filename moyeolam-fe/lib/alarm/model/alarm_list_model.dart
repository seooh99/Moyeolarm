// To parse this JSON data, do
//
//     final alarmListModel = alarmListModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'alarm_list_model.g.dart';

@JsonSerializable()
class AlarmListModel {
  final String code;
  final String message;
  final Data data;

  AlarmListModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory AlarmListModel.fromJson(Map<String, dynamic> json) => _$AlarmListModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmListModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Data {
  final List<AlarmGroups> alarmGroups;

  Data({
    required this.alarmGroups,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}


@JsonSerializable()
class AlarmGroups {
  final int alarmGroupId;
  final String title;
  final int hour;
  final int minute;
  final List<bool> dayOfWeek;
  final bool isLock;
  final bool toggle;

  AlarmGroups({
    required this.alarmGroupId,
    required this.title,
    required this.hour,
    required this.minute,
    required this.dayOfWeek,
    required this.isLock,
    required this.toggle,
  });

  factory AlarmGroups.fromJson(Map<String, dynamic> json) => _$AlarmGroupsFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmGroupsToJson(this);
}
