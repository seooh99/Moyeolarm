// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arlet_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiArletModel _$ApiArletModelFromJson(Map<String, dynamic> json) =>
    ApiArletModel(
      fromNickname: json['fromNickname'] as String,
      title: json['title'] as String,
      time: json['time'] as bool,
      alertType: json['alertType'] as String,
      createAt: json['createAt'] as int,
    );

Map<String, dynamic> _$ApiArletModelToJson(ApiArletModel instance) =>
    <String, dynamic>{
      'fromNickname': instance.fromNickname,
      'title': instance.title,
      'time': instance.time,
      'alertType': instance.alertType,
      'createAt': instance.createAt,
    };
