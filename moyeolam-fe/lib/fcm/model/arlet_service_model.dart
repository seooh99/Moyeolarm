import 'package:json_annotation/json_annotation.dart';

part 'arlet_service_model.g.dart';

@JsonSerializable()
class ApiArletModel {
  String fromNickname;
  String title;
  bool time;
  String alertType;
  int createAt;

  ApiArletModel({
    required this.fromNickname,
    required this.title,
    required this.time,
    required this.alertType,
    required this.createAt,
  });
}
