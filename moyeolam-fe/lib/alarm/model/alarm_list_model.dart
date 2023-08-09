// To parse this JSON data, do
//
//     final alarmListModel = alarmListModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'alarm_list_model.g.dart';

// AlarmListModel alarmListModelFromJson(String str) => AlarmListModel.fromJson(json.decode(str));
//
// String alarmListModelToJson(AlarmListModel data) => json.encode(data.toJson());

@JsonSerializable()
class AlarmListResponseModel {
  final String code;
  final String message;
  final AlarmListModel data;

  AlarmListResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  // AlarmListModel copyWith({
  //   String? code,
  //   String? message,
  //   Data? data,
  // }) =>
  //     AlarmListModel(
  //       code: code ?? this.code,
  //       message: message ?? this.message,
  //       data: data ?? this.data,
  //     );

  factory AlarmListResponseModel.fromJson(Map<String, dynamic> json) => _$AlarmListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmListResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AlarmListModel {
  final List<AlarmGroups> alarmGroups;

  AlarmListModel({
    required this.alarmGroups,
  });

  // Data copyWith({
  //   List<AlarmGroups>? alarmGroups,
  // }) =>
  //     Data(
  //       alarmGroups: alarmGroups ?? this.alarmGroups,
  //     );

  factory AlarmListModel.fromJson(Map<String, dynamic> json) => _$AlarmListModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmListModelToJson(this);
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

  // AlarmGroups copyWith({
  //   int? alarmGroupId,
  //   String? title,
  //   int? hour,
  //   int? minute,
  //   List<bool>? dayOfWeek,
  //   bool? isLock,
  //   bool? toggle,
  // }) =>
  //     AlarmGroups(
  //       alarmGroupId: alarmGroupId ?? this.alarmGroupId,
  //       title: title ?? this.title,
  //       hour: hour ?? this.hour,
  //       minute: minute ?? this.minute,
  //       dayOfWeek: dayOfWeek ?? this.dayOfWeek,
  //       isLock: isLock ?? this.isLock,
  //       toggle: toggle ?? this.toggle,
  //     );

  factory AlarmGroups.fromJson(Map<String, dynamic> json) => _$AlarmGroupsFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmGroupsToJson(this);
}
