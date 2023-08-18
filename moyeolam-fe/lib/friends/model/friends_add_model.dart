
import 'package:json_annotation/json_annotation.dart';

part 'friends_add_model.g.dart';

// To parse this JSON data, do
//
//     final alarmListModel = alarmListModelFromJson(jsonString);

// AlarmListModel alarmListModelFromJson(String str) => AlarmListModel.fromJson(json.decode(str));
//
// String alarmListModelToJson(AlarmListModel data) => json.encode(data.toJson());

@JsonSerializable()
class FriendsAddResponseModel {
  final String code;
  final String message;
  final int? data;

  FriendsAddResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory FriendsAddResponseModel.fromJson(Map<String, dynamic> json) => _$FriendsAddResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsAddResponseModelToJson(this);
}

