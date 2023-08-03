import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter/material.dart';

part 'alarm.g.dart';

@JsonSerializable()
class Alarm {
  final String title;

  Alarm({required this.title});

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);

  Map<String, dynamic> toJson() => _$AlarmToJson(this);
}

part 'alarm_service.g.dart';

@RestApi()
abstract class AlarmService {
  factory AlarmService(Dio dio, {String? baseUrl}) = _AlarmService;

  @GET("/alarms")
  Future<List<Alarm>> getAlarms();
}

@RestApi(baseUrl: "your_base_url_here")
abstract class _AlarmService extends AlarmService {
  _AlarmService(Dio dio, {String? baseUrl}): super(dio, baseUrl: baseUrl);
}


class AlarmList extends StatefulWidget {
  @override
  _AlarmListState createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  List<Alarm> alarms = [];

  @override
  void initState() {
    super.initState();
    fetchAlarms();
  }

  fetchAlarms() async {
    final dio = Dio();
    final alarmService = AlarmService(dio);
    alarms = await alarmService.getAlarms();
    setState(() {}); // UI를 갱신합니다.
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: alarms.length,
      itemBuilder: (context, index) {
        final alarm = alarms[index];
        return ListTile(
          title: Text(alarm.title),
          // 여기에 더 많은 디자인과 로직을 추가할 수 있습니다.
        );
      },
    );
  }
}
