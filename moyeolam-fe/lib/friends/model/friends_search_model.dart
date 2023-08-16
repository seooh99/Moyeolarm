// To parse this JSON data, do
//
//     final friendsSearchModel = friendsSearchModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:youngjun/friends/model/friends_list_model.dart';

part 'friends_search_model.g.dart';

// FriendsSearchModel friendsSearchModelFromJson(String str) => FriendsSearchModel.fromJson(json.decode(str));
//
// String friendsSearchModelToJson(FriendsSearchModel data) => json.encode(data.toJson());

@JsonSerializable()
class FriendsSearchResponseModel {
  String code;
  String message;
  ListFriendModel data;

  FriendsSearchResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory FriendsSearchResponseModel.fromJson(Map<String, dynamic> json) => _$FriendsSearchResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsSearchResponseModelToJson(this);
}

