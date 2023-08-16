import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user_search_model.g.dart';

MemberModel memberModelFromJson(String str) => MemberModel.fromJson(json.decode(str));

String memberModelToJson(MemberModel data) => json.encode(data.toJson());

@JsonSerializable()
class UserSearchResponseModel {
  String code;
  String message;
  MemberModel? data;

  UserSearchResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory UserSearchResponseModel.fromJson(Map<String, dynamic> json) => _$UserSearchResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserSearchResponseModelToJson(this);
}

// @JsonSerializable()
// class Member {
//   MemberModel? member;
//
//   Member({
//     required this.member,
//   });
//
//   factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
//
//   Map<String, dynamic> toJson() => _$MemberToJson(this);
// }

@JsonSerializable()
class MemberModel {
  int memberId;
  String nickname;
  String? profileImageUrl;
  bool isFriend;

  MemberModel({
    required this.memberId,
    required this.nickname,
    required this.profileImageUrl,
    required this.isFriend,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) => _$MemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);
}
