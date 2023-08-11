import 'package:json_annotation/json_annotation.dart';

part 'alarm_toggle_model.g.dart';

@JsonSerializable()
class AlarmToggleResponseModel {
  final String code;
  final String message;
  final bool data;

  AlarmToggleResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory AlarmToggleResponseModel.fromJson(Map<String, dynamic> json) => _$AlarmToggleResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlarmToggleResponseModelToJson(this);
}