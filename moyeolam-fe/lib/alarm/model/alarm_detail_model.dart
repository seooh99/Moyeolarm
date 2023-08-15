import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'alarm_detail_model.g.dart';

@JsonSerializable()
class AlarmDetailResponseModel {
  final String code;
  final String message;
  final AlarmDetailData data;

  AlarmDetailResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory AlarmDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AlarmDetailResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlarmDetailResponseModelToJson(this);
}
@JsonSerializable()
class AlarmDetailData{
  final AlarmGroup alarmGroup;
  AlarmDetailData({
    required this.alarmGroup,
});
  factory AlarmDetailData.fromJson(Map<String, dynamic> json) =>
      _$AlarmDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmDetailDataToJson(this);
}

// @JsonSerializable()
// class AlarmDetailModel {
//   final int alarmGroupId;
//   final String title;
//   final int hour;
//   final int minute;
//   final List<bool> dayOfWeek;
//   final String alarmSound;
//   final String alarmMission;
//   final bool isHost;
//   final List<AlarmMember?> members;
//   // final String ampm;
//
//   AlarmDetailModel({
//     required this.alarmGroupId,
//     required this.title,
//     required this.hour,
//     required this.minute,
//     required this.dayOfWeek,
//     required this.alarmSound,
//     required this.alarmMission,
//     required this.isHost,
//     required this.members,
// });
//
//   factory AlarmDetailModel.fromJson(Map<String, dynamic> json) =>
//       _$AlarmDetailModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$AlarmDetailModelToJson(this);
// }


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
  List<AlarmMember> members;

  AlarmGroup({
    required this.alarmGroupId,
    required this.title,
    required this.hour,
    required this.minute,
    required this.dayOfWeek,
    required this.alarmSound,
    required this.alarmMission,
    required this.isHost,
    required this.isLock,
    required this.members,
  });

  // AlarmDetailModel copyWith(int? alarmGroupId, int? hour, int? minute,String? title, String? ampm) {
  //   return AlarmDetailModel(
  //     alarmGroupId: this.alarmGroupId,
  //     hour: hour ?? this.hour,
  //     minute: minute ?? this.minute,
  //     title: title ?? this.title,
  //     ampm: ampm ?? this.ampm,
  //
  //   );
  // }

  factory AlarmGroup.fromJson(Map<String, dynamic> json) =>
      _$AlarmGroupFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmGroupToJson(this);
}

@JsonSerializable()
class AlarmMember {
  final int memberId;
  final String nickname;
  final String? profileUrl;
  final bool isHost;
  final bool isToggle;

  AlarmMember({
    required this.memberId,
    required this.nickname,
    required this.profileUrl,
    required this.isHost,
    required this.isToggle,
  });

  factory AlarmMember.fromJson(Map<String, dynamic> json) =>
      _$AlarmMemberFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmMemberToJson(this);
}
