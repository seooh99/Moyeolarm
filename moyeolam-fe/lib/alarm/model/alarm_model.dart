
import 'package:json_annotation/json_annotation.dart';

part 'alarm_model.g.dart';

@JsonSerializable()
class AlarmModel{

  final String title;
  final bool use;
  final String day;
  final String time;

  AlarmModel({

    required this.title,
    required this.use,
    required this.day,
    required this.time,
});

factory AlarmModel.fromJson(Map<String, dynamic> json)
  =>_$AlarmModelFromJson(json);

Map<String, dynamic> toJson() => _$AlarmModelToJson(this);
}