// To parse this JSON data, do
//
//     final friendsSearchModel = friendsSearchModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'friends_search_model.g.dart';

// FriendsSearchModel friendsSearchModelFromJson(String str) => FriendsSearchModel.fromJson(json.decode(str));
//
// String friendsSearchModelToJson(FriendsSearchModel data) => json.encode(data.toJson());

@JsonSerializable()
class FriendsSearchModel {
  String code;
  String message;
  Data data;

  FriendsSearchModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory FriendsSearchModel.fromJson(Map<String, dynamic> json) => _$FriendsSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsSearchModelToJson(this);
}

@JsonSerializable()
class Data {
  List<Friend> friends;

  Data({
    required this.friends,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Friend {
  int memberId;
  String nickname;
  String? profileImageUrl;

  Friend({
    required this.memberId,
    required this.nickname,
    required this.profileImageUrl,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);

  Map<String, dynamic> toJson() => _$FriendToJson(this);
}
