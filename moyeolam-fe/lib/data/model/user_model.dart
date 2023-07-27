import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  late final int userId;
  late final int oauthType;
  late final String oauthIndex;
  late final String fcmToken;
  late String? nickname;
  late final DateTime signDate;

  User({
    required this.userId,
    required this.oauthType,
    required this.oauthIndex,
    required this.fcmToken,
    this.nickname,
    required this.signDate,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['userId'],
        oauthType: json['oauthType'],
        oauthIndex: json['oauthIndex'],
        fcmToken: json['fcmToken'],
        nickname: json['nickname'],
        signDate: json['signDate'],
      );
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'oauthType': oauthType,
        'oauthIndex': oauthIndex,
        'fcmToken': fcmToken,
        'nickname': nickname,
        'signDate': signDate,
      };
}
