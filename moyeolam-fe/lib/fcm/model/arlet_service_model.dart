import 'package:json_annotation/json_annotation.dart';

part 'arlet_service_model.g.dart';

@JsonSerializable()
class ApiArletModel {
  String fromNickname;
  String title;
  bool time;
  String alertType;
  int createAt;

  ApiArletModel({
    required this.fromNickname,
    required this.title,
    required this.time,
    required this.alertType,
    required this.createAt,
  });
  factory ApiArletModel.fromJson(Map<String, dynamic> json) =>
      _$ApiArletModelFromJson(json); // 추가

  Map<String, dynamic> toJson() => _$ApiArletModelToJson(this); // 추가
}
