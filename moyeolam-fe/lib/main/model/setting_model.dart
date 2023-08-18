import 'package:json_annotation/json_annotation.dart';

part 'setting_model.g.dart';

@JsonSerializable()
class FetchSettingModel {
  String? code; // 에러 코드
  String? message; // 에러 메시지
  FetchSettingData? data; // 실제 데이터

  FetchSettingModel({
    this.code,
    this.message,
    this.data,
  });

  factory FetchSettingModel.fromJson(Map<String, dynamic> json) {
    return FetchSettingModel(
      code: json['code'],
      message: json['message'],
      data: FetchSettingData.fromJson(json['data']),
    );
  }
}

@JsonSerializable()
class FetchSettingData {
  bool? isNotificationToggle;

  FetchSettingData({
    this.isNotificationToggle,
  });

  factory FetchSettingData.fromJson(Map<String, dynamic> json) {
    return FetchSettingData(
        isNotificationToggle: json['isNotificationToggle'] as bool,
        );
  }
}

@JsonSerializable()
class ChangeSettingModel {
  String? code; // 에러 코드
  String? message; // 에러 메시지
  bool? data; // 실제 데이터

  ChangeSettingModel({
    this.code,
    this.message,
    this.data,
  });

  factory ChangeSettingModel.fromJson(Map<String, dynamic> json) {
    return ChangeSettingModel(
      code: json['code'],
      message: json['message'],
      data: json['data'] as bool,
    );
  }
}

