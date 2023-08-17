import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'alert_service_model.g.dart';


@JsonSerializable()
class ApiArletModel {
  String? code;
  String? message;
  ApiArletData? data;

  ApiArletModel({
    this.code,
    this.message,
    this.data,
  });

  factory ApiArletModel.fromJson(Map<String, dynamic> json) {
    return ApiArletModel(
      code: json['code'],
      message: json['message'],
      data: ApiArletData.fromJson(json['data']),
    );
  }

  @override
  String toString() {
    return 'ApiArletModel(code: $code, message: $message, data: $data)';
  }
}

@JsonSerializable()
class ApiArletData {
  List<ApiArletItem?>? alerts;

  ApiArletData({
    this.alerts,
  });

  factory ApiArletData.fromJson(Map<String, dynamic> json) {
    return ApiArletData(
      alerts: (json['alerts'] as List<dynamic>?)?.map((e) => ApiArletItem.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  String toString() {
    return 'ApiArletData(alerts: $alerts)';
  }
}

@JsonSerializable()
class ApiArletItem {
  String? fromNickname;
  String? title;
  String? time;
  String? alertType;
  String? createAt;
  int? alarmGroupId;
  int? friendRequestId;
  int? fromMemberId;

  ApiArletItem({
    this.fromNickname,
    this.title,
    this.time,
    this.alertType,
    this.createAt,
    this.alarmGroupId,
    this.friendRequestId,
    this.fromMemberId,
  });

  factory ApiArletItem.fromJson(Map<String, dynamic> json) {
    return ApiArletItem(
      fromNickname: json['fromNickname'] as String?,
      title: json['title'] as String?,
      time: json['time'] as String?,
      alertType: json['alertType'] as String?,
      createAt: json['createAt'] as String?,
      alarmGroupId: json['alarmGroupId'] as int?,
      friendRequestId: json['friendRequestId'] as int?,
      fromMemberId: json['fromMemberId'] as int,
    );
  }

  @override
  String toString() {
    return 'ApiArletItem(fromNickname: $fromNickname, title: $title, time: $time, alertType: $alertType, createAt: $createAt, alarmGroupId: $alarmGroupId, friendRequestId: $friendRequestId, fromMemberId: $fromMemberId)';
  }
}



