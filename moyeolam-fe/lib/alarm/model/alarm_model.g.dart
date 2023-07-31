// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmModel _$AlarmModelFromJson(Map<String, dynamic> json) => AlarmModel(
      title: json['title'] as String,
      use: json['use'] as bool,
      day: json['day'] as String,
      time: json['time'] as String,
    );

Map<String, dynamic> _$AlarmModelToJson(AlarmModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'use': instance.use,
      'day': instance.day,
      'time': instance.time,
    };
