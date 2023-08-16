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
class FriendsListResponseModel {
  String code;
  String message;
  ListFriendModel data;

  FriendsListResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory FriendsListResponseModel.fromJson(Map<String, dynamic> json) => _$FriendsListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsListResponseModelToJson(this);
}

@JsonSerializable()
class ListFriendModel {
  List<FriendModel?> friends;

  ListFriendModel({
    required this.friends,
  });

  factory ListFriendModel.fromJson(Map<String, dynamic> json) => _$ListFriendModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListFriendModelToJson(this);
}

@JsonSerializable()
class FriendModel {
  int memberId;
  String nickname;
  String? profileImageUrl;

  FriendModel({
    required this.memberId,
    required this.nickname,
    this.profileImageUrl,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) => _$FriendModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendModelToJson(this);
}
