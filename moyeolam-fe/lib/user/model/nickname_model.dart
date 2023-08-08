import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:youngjun/user/model/user_model.dart';
part 'nickname_model.g.dart';

@JsonSerializable()
class NicknamePost {
  @JsonKey(name: "nickname")
  String nickname;

  NicknamePost({required this.nickname});
  factory NicknamePost.fromJson(Map<String, dynamic> json) =>
      _$NicknamePostFromJson(json);
  Map<String, dynamic> toJson() => _$NicknamePostToJson(this);
}

@JsonSerializable()
class NicknameResposne {
  String code;
  String message;
  int? data;

  NicknameResposne({
    required this.code,
    required this.message,
    required this.data,
  });
  factory NicknameResposne.fromJson(Map<String, dynamic> json) =>
      _$NicknameResposneFromJson(json);
  Map<String, dynamic> toJson() => _$NicknameResposneToJson(this);
}
