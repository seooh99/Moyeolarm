import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'alarm_detail_model.g.dart';

@JsonSerializable()
class AlarmGroupModel {
  String code;
  String message;
  Data data;

  AlarmGroupModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory AlarmGroupModel.fromJson(Map<String, dynamic> json) =>
      _$AlarmGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmGroupModelToJson(this);
}

@JsonSerializable()
class Data {
  AlarmGroup alarmGroup;

  Data({
    required this.alarmGroup,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class AlarmGroup {
  int alarmGroupId;
  String title;
  int hour;
  int minute;
  List<bool> dayOfWeek;
  String alarmSound;
  String alarmMission;
  bool isLock;
  bool isHost;
  List<Member>? members;

  AlarmGroup({
    required this.alarmGroupId,
    required this.title,
    required this.hour,
    required this.minute,
    required this.dayOfWeek,
    required this.alarmSound,
    required this.alarmMission,
    required this.isLock,
    required this.isHost,
    this.members,
  });

  factory AlarmGroup.fromJson(Map<String, dynamic> json) => _$AlarmGroupFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmGroupToJson(this);
}

@JsonSerializable()
class Member {
  int memberId;
  String nickname;
  String? profileImageUrl;
  bool isHost;
  bool toggle;

  Member({
    required this.memberId,
    required this.nickname,
    this.profileImageUrl,
    required this.isHost,
    required this.toggle,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
