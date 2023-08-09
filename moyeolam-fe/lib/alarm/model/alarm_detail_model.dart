library alarm_detail_model;

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alarm_detail_model.g.dart';

@JsonSerializable()
class AlarmDetailResponseModel{
  final String code;
  final String message;
  final AlarmDetailModel data;

  AlarmDetailResponseModel({
   required this.code,
   required this.message,
   required this.data,
});

  factory AlarmDetailResponseModel.fromJson(Map<String, dynamic> json) => _$AlarmDetailResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlarmDetailResponseModelToJson(this);

}


@JsonSerializable()
@immutable
class AlarmDetailModel {

  final int alarmGroupId;
  final String title;
  final int hour;
  final int minute;
  final List<bool> dayOfWeek;
  final String alarmSound;
  final String alarmMission;
  final bool isHost;
  final List<AlarmMember> members;
  // final String ampm;


  const AlarmDetailModel({
    required this.alarmGroupId,
    required this.title,
    required this.hour,
    required this.minute,
    required this.dayOfWeek,
    required this.alarmSound,
    required this.alarmMission,
    required this.isHost,
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

  factory AlarmDetailModel.fromJson(Map<String, dynamic> json) => _$AlarmDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmDetailModelToJson(this);




}

@JsonSerializable()
class AlarmMember{
  final int memberId;
  final String nickname;
  final String profileUrl;
  final bool isHost;
  final bool toggle;

  AlarmMember({
    required this.memberId,
    required this.nickname,
    required this.profileUrl,
    required this.isHost,
    required this.toggle,
});

  factory AlarmMember.fromJson(Map<String, dynamic> json) => _$AlarmMemberFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmMemberToJson(this);



}