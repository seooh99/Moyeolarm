import 'package:json_annotation/json_annotation.dart';
// List<User> userFromJson(String str) =>
//     List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
// String userToJson(List<User> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

part 'user_model.g.dart';

@JsonSerializable()
class User {
  late String? nickname;
  // late List<String> friendsList;
  // late List<Map<String, dynamic>> roomList;
  // late String accessToken;
  // late String refreshToken;

  User(
    this.nickname,
    // required this.friendsList,
    // required this.roomList,
    // required this.accessToken,
    // required this.refreshToken,
  );

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
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
