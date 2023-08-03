// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmDetailModel _$AlarmDetailModelFromJson(Map<String, dynamic> json) =>
    AlarmDetailModel(
      alarmGroupId: json['alarmGroupId'] as int,
      hour: json['hour'] as int,
      minute: json['minute'] as int,
      ampm: json['ampm'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$AlarmDetailModelToJson(AlarmDetailModel instance) =>
    <String, dynamic>{
      'alarmGroupId': instance.alarmGroupId,
      'hour': instance.hour,
      'minute': instance.minute,
      'ampm': instance.ampm,
      'title': instance.title,
    };
