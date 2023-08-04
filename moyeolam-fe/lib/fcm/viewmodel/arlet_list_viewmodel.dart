import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youngjun/fcm/model/arlet_service.dart';

// part 'alarm_service.g.dart';

@RestApi()
abstract class AlarmService {
  // factory AlarmService(Dio dio, {String? baseUrl}) = _AlarmService;

  @GET("/alarms")
  Future<List<Alarm>> getAlarms();
}
//
// @RestApi(baseUrl: "your_base_url_here")
// abstract class _AlarmService extends AlarmService {
//   _AlarmService(Dio dio, {String? baseUrl}): super(dio, baseUrl: baseUrl);
// }
