import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  late String nickname;
  // late List<String> friendsList;
  // late List<Map<String, dynamic>> roomList;
  // late String accessToken;
  // late String refreshToken;

  User({
    required this.nickname,
    // required this.friendsList,
    // required this.roomList,
    // required this.accessToken,
    // required this.refreshToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        nickname: json['nickname'],
        // friendsList: json['friendsList'],
        // roomList: json['roomList'],
        // accessToken: json['accessToken'],
        // refreshToken: json['refreshTokens'],
      );
  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        // 'accessToken': accessToken,
        // 'refreshToken': refreshToken,
        // 'friendsList': friendsList,
        // 'roomList': roomList,
      };
}
