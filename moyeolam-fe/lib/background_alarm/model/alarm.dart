import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alarm.g.dart';

@JsonSerializable()
@immutable
class Alarm {
  final int alarmGroupId;
  /// 7의 배수 중 하나로 된 정수이다.
  final int callbackId;

  /// sun, mon, ... , sat
  final List<bool> weekday;

  final int hour;
  final int minute;
  final bool toggle;

  const Alarm({
    required this.alarmGroupId,
    required this.callbackId,
    required this.weekday,
    required this.hour,
    required this.minute,
    required this.toggle,
  })  : assert(0 <= hour && hour < 24),
        assert(0 <= minute && minute < 60),
        assert(weekday.length == 7);

  int callbackIdOf(int weekday) {
    return callbackId + weekday;
  }

  Alarm copyWith({List<bool>? dayOfWeek, int? hour, int? minute, bool? toggle}) {
    return Alarm(
      alarmGroupId: 1,
      callbackId: callbackId,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      toggle: toggle ?? this.toggle,
      weekday: dayOfWeek ?? weekday,
    );
  }

  TimeOfDay get timeOfDay => TimeOfDay(hour: hour, minute: minute);

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmToJson(this);
}
