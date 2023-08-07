import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alarm_list_model.g.dart';

@JsonSerializable()
@immutable
class AlarmListModel {

  final int alarmGroupId;
  final List<bool> weekday;
  final int hour;
  final int minute;
  final bool toggle;
  final String title;

  const AlarmListModel({
    required this.alarmGroupId,
    this.weekday = const [true, true, true, true, true, true, true],
    required this.hour,
    required this.minute,
    required this.toggle,
    required this.title,
  })  : assert(0 <= hour && hour < 24),
        assert(0 <= minute && minute < 60),
        assert(weekday.length == 7);

  // int callbacIdOf(int weekday) {
  //   return alarmGroupId + weekday;
  // }

  AlarmListModel copyWith(int? alarmGroupId, int? hour, int? minute, bool? toggle, String? title) {
    return AlarmListModel(
      alarmGroupId: this.alarmGroupId,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      toggle: toggle ?? this.toggle,
      title: title ?? this.title,
      weekday: weekday ?? this.weekday,
    );
  }

  TimeOfDay get timeOfDay =>TimeOfDay(hour: hour, minute: minute);

  factory AlarmListModel.fromJson(Map<String, dynamic> json) => _$AlarmListModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmListModelToJson(this);
}
