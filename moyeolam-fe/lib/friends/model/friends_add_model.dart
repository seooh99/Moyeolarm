
import 'package:json_annotation/json_annotation.dart';

part 'friends_add_model.g.dart';

// To parse this JSON data, do
//
//     final alarmListModel = alarmListModelFromJson(jsonString);

// AlarmListModel alarmListModelFromJson(String str) => AlarmListModel.fromJson(json.decode(str));
//
// String alarmListModelToJson(AlarmListModel data) => json.encode(data.toJson());

@JsonSerializable()
class FriendsAddModel {
  final String code;
  final String message;
  final Data data;

  FriendsAddModel({
    required this.code,
    required this.message,
    required this.data,
  });

  // AlarmListModel copyWith({
  //   String? code,
  //   String? message,
  //   Data? data,
  // }) =>
  //     AlarmListModel(
  //       code: code ?? this.code,
  //       message: message ?? this.message,
  //       data: data ?? this.data,
  //     );

  factory FriendsAddModel.fromJson(Map<String, dynamic> json) => _$FriendsAddModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsAddModelToJson(this);
}

@JsonSerializable()
class Data {
  final Data memberId;

  Data({
    required this.memberId,
  });

  // Data copyWith({
  //   List<AlarmGroups>? alarmGroups,
  // }) =>
  //     Data(
  //       alarmGroups: alarmGroups ?? this.alarmGroups,
  //     );

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
