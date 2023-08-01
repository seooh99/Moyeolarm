// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alarm _$AlarmFromJson(Map<String, dynamic> json) => Alarm(
      alarmGroupId: json['alarmGroupId'] as int,
      weekday:
          (json['weekday'] as List<dynamic>?)?.map((e) => e as bool).toList() ??
              const [true, true, true, true, true, true, true],
      hour: json['hour'] as int,
      minute: json['minute'] as int,
      toggle: json['toggle'] as bool,
      title: json['title'] as String,
    );

Map<String, dynamic> _$AlarmToJson(Alarm instance) => <String, dynamic>{
      'alarmGroupId': instance.alarmGroupId,
      'weekday': instance.weekday,
      'hour': instance.hour,
      'minute': instance.minute,
      'toggle': instance.toggle,
      'title': instance.title,
    };
