import 'package:json_annotation/json_annotation.dart';

part 'add_friend_alarm_group_model.g.dart';

@JsonSerializable()
class AddFriendAlarmGroupResponseModel{
  final String code;
  final String message;
  final List<int?> data;

  AddFriendAlarmGroupResponseModel({
    required this.code,
    required this.message,
    required this.data,
});

  factory AddFriendAlarmGroupResponseModel.fromJson(Map<String, dynamic> json) => _$AddFriendAlarmGroupResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddFriendAlarmGroupResponseModelToJson(this);

}

@JsonSerializable()
class AddFriendAlarmGroupRequestModel{
  final List<int?> memberIds;
  AddFriendAlarmGroupRequestModel({
    required this.memberIds,
});

  factory AddFriendAlarmGroupRequestModel.fromJson(Map<String, dynamic> json) => _$AddFriendAlarmGroupRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddFriendAlarmGroupRequestModelToJson(this);
}
