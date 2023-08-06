import 'package:json_annotation/json_annotation.dart';
// List<User> userFromJson(String str) =>
//     List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
// String userToJson(List<User> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

part 'user_model.g.dart';

// SignIn 확인용 request 모델
@JsonSerializable()
class IsSigned{
  @JsonKey(name: "oauthIdentifier")
  String oauthIdentifier;

  IsSigned({required this.oauthIdentifier});
  factory IsSigned.fromJson(Map<String, dynamic> json) => _$IsSignedFromJson(json);
  Map<String, dynamic> toJson() => _$IsSignedToJson(this);
}

@JsonSerializable()
class NicknamePost{
  @JsonKey(name: "nickname")
  String nickname;

  NicknamePost({required this.nickname});
  factory NicknamePost.fromJson(Map<String, dynamic> json) => _$NicknamePostFromJson(json);
  Map<String, dynamic> toJson() => _$NicknamePostToJson(this);
}

@JsonSerializable()
class NicknameResposne{
  int memberId;
  NicknameResposne({required this.memberId});
  factory NicknameResposne.fromJson(Map<String, dynamic> json) => _$NicknameResposneFromJson(json);
  Map<String, dynamic> toJson() => _$NicknameResposneToJson(this);
}

// response용 User 모델
@JsonSerializable()
class UserModel {
  String? nickname;
  String accessToken;
  String refreshToken;
  String? profileImageUrl;

  UserModel(
    this.nickname,
    this.accessToken,
    this.refreshToken,
    this.profileImageUrl,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  // factory User.fromJson(Map<String, dynamic> json) => User(
  //       nickname: json['nickname'],
  //       // friendsList: json['friendsList'],
  //       // roomList: json['roomList'],
  //       // accessToken: json['accessToken'],
  //       // refreshToken: json['refreshTokens'],
  //     );
  // Map<String, dynamic> toJson() => {
  //       'nickname': nickname,
  //       // 'accessToken': accessToken,
  //       // 'refreshToken': refreshToken,
  //       // 'friendsList': friendsList,
  //       // 'roomList': roomList,
  //     };
}
