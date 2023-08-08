import 'package:json_annotation/json_annotation.dart';
// List<User> userFromJson(String str) =>
//     List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
// String userToJson(List<User> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

part 'user_model.g.dart';

// SignIn 확인용 request 모델
@JsonSerializable()
class IsSigned {
  @JsonKey(name: "oauthIdentifier")
  String oauthIdentifier;

  IsSigned({required this.oauthIdentifier});
  factory IsSigned.fromJson(Map<String, dynamic> json) =>
      _$IsSignedFromJson(json);
  Map<String, dynamic> toJson() => _$IsSignedToJson(this);
}

@JsonSerializable()
class ResponseUserModel {
  String code;
  String message;
  UserModel data;

  ResponseUserModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ResponseUserModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseUserModelToJson(this);
}

// response용 User 모델
@JsonSerializable()
class UserModel {
  String? nickname;
  String? profileImageUrl;
  String accessToken;
  String refreshToken;

  UserModel(
    this.nickname,
    this.accessToken,
    this.refreshToken,
    this.profileImageUrl,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
