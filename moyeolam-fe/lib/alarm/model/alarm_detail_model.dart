
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alarm_detail_model.g.dart';

@JsonSerializable()
@immutable
class AlarmDetailModel {

  final int alarmGroupId;
  final int hour;
  final int minute;
  final String ampm;
  final String title;

  const AlarmDetailModel({
    required this.alarmGroupId,
    required this.hour,
    required this.minute,
    required this.ampm,
    required this.title,
});

  AlarmDetailModel copyWith(int? alarmGroupId, int? hour, int? minute,String? title) {
    return AlarmDetailModel(
      alarmGroupId: this.alarmGroupId,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      title: title ?? this.title,
      ampm: ampm ?? this.ampm,

    );
  }

  factory AlarmDetailModel.fromJson(Map<String, dynamic> json) => _$AlarmDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmDetailModelToJson(this);




}