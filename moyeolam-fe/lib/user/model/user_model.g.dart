// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IsSigned _$IsSignedFromJson(Map<String, dynamic> json) => IsSigned(
      oauthIdentifier: json['oauthIdentifier'] as String,
    );

Map<String, dynamic> _$IsSignedToJson(IsSigned instance) => <String, dynamic>{
      'oauthIdentifier': instance.oauthIdentifier,
    };

NicknamePost _$NicknamePostFromJson(Map<String, dynamic> json) => NicknamePost(
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$NicknamePostToJson(NicknamePost instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
    };

NicknameResposne _$NicknameResposneFromJson(Map<String, dynamic> json) =>
    NicknameResposne(
      memberId: json['memberId'] as int,
    );

Map<String, dynamic> _$NicknameResposneToJson(NicknameResposne instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['nickname'] as String?,
      json['accessToken'] as String,
      json['refreshToken'] as String,
      json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'profileImageUrl': instance.profileImageUrl,
    };
