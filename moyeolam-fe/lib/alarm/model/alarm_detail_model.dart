import 'dart:convert';

AlarmGroupDetail alarmGroupDetailFromJson(String str) => AlarmGroupDetail.fromJson(json.decode(str));

String alarmGroupDetailToJson(AlarmGroupDetail data) => json.encode(data.toJson());

class AlarmGroupDetail {
  String code;
  String message;
  Data data;

  AlarmGroupDetail({
    required this.code,
    required this.message,
    required this.data,
  });

  factory AlarmGroupDetail.fromJson(Map<String, dynamic> json) => AlarmGroupDetail(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  AlarmGroup alarmGroup;

  Data({
    required this.alarmGroup,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    alarmGroup: AlarmGroup.fromJson(json["alarmGroup"]),
  );

  Map<String, dynamic> toJson() => {
    "alarmGroup": alarmGroup.toJson(),
  };
}

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
  List<Member> members;

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
    required this.members,
  });

  factory AlarmGroup.fromJson(Map<String, dynamic> json) => AlarmGroup(
    alarmGroupId: json["alarmGroupId"],
    title: json["title"],
    hour: json["hour"],
    minute: json["minute"],
    dayOfWeek: List<bool>.from(json["dayOfWeek"].map((x) => x)),
    alarmSound: json["alarmSound"],
    alarmMission: json["alarmMission"],
    isLock: json["isLock"],
    isHost: json["isHost"],
    members: List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "alarmGroupId": alarmGroupId,
    "title": title,
    "hour": hour,
    "minute": minute,
    "dayOfWeek": List<dynamic>.from(dayOfWeek.map((x) => x)),
    "alarmSound": alarmSound,
    "alarmMission": alarmMission,
    "isLock": isLock,
    "isHost": isHost,
    "members": List<dynamic>.from(members.map((x) => x.toJson())),
  };
}

class Member {
  int memberId;
  String nickname;
  String profileImageUrl;
  bool isHost;
  bool toggle;

  Member({
    required this.memberId,
    required this.nickname,
    required this.profileImageUrl,
    required this.isHost,
    required this.toggle,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    memberId: json["memberId"],
    nickname: json["nickname"],
    profileImageUrl: json["profileImageUrl"],
    isHost: json["isHost"],
    toggle: json["toggle"],
  );

  Map<String, dynamic> toJson() => {
    "memberId": memberId,
    "nickname": nickname,
    "profileImageUrl": profileImageUrl,
    "isHost": isHost,
    "toggle": toggle,
  };
}
