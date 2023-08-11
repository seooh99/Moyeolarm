// To parse this JSON data, do
//
//     final firendsListModel = firendsListModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'friends_list_model.g.dart';

// FriendsListModel firendsListModelFromJson(String str) => FriendsListModel.fromJson(json.decode(str));
//
// String firendsListModelToJson(FriendsListModel data) => json.encode(data.toJson());

@JsonSerializable()
class FriendsListModel {
  String code;
  String message;
  Data data;

  FriendsListModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory FriendsListModel.fromJson(Map<String, dynamic> json) => _$FriendsListModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsListModelToJson(this);
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
  dynamic profileImageUrl;

  Friend({
    required this.memberId,
    required this.nickname,
    this.profileImageUrl,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);

  Map<String, dynamic> toJson() => _$FriendToJson(this);
}
