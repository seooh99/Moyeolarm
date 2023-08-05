
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'api_model.g.dart';

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

  factory ApiArletModel.fromJson(Map<String, dynamic> json) => _$ApiArletModelFromJson(json);
  Map<String,dynamic> toJson() => _$ApiArletModelFromJson(this);
}
