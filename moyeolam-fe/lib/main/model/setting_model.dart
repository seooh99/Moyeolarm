import 'package:json_annotation/json_annotation.dart';

part 'setting_model.g.dart';

@JsonSerializable()
class SettingModel {
  String? code; // 에러 코드
  String? message; // 에러 메시지
  bool? data; // 실제 데이터

  SettingModel({
    this.code,
    this.message,
    this.data,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      code: json['code'],
      message: json['message'],
      data: json['data'],
    );
  }
}