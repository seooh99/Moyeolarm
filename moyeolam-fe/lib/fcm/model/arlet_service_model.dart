import 'package:json_annotation/json_annotation.dart';

// part 'alarm.g.dart';

@JsonSerializable()
class Alarm {
  final String title;

  Alarm({required this.title});

// factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);
//
// Map<String, dynamic> toJson() => _$AlarmToJson(this);
}
