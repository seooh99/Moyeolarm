import 'package:json_annotation/json_annotation.dart';

part 'delete_friend_alarm_group_model.g.dart';

@JsonSerializable()
class AlarmGroupDeleteFriendRequestModel {
  final int memberId;

  AlarmGroupDeleteFriendRequestModel({
    required this.memberId,
});

  factory AlarmGroupDeleteFriendRequestModel.fromJson(Map<String, dynamic> json) => _$AlarmGroupDeleteFriendRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlarmGroupDeleteFriendRequestModelToJson(this);
}

@JsonSerializable()
class AlarmGroupDeleteFriendResponseModel{
  final String code;
  final String message;
  final int? data;

  AlarmGroupDeleteFriendResponseModel({
    required this.code,
    required this.message,
    required this.data,
});

  factory AlarmGroupDeleteFriendResponseModel.fromJson(Map<String, dynamic> json) => _$AlarmGroupDeleteFriendResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlarmGroupDeleteFriendResponseModelToJson(this);
}
