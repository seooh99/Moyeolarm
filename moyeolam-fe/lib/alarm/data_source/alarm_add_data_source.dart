import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:youngjun/alarm/model/alarm_list_model.dart';

part 'alarm_add_data_source.g.dart';

@RestApi()
abstract class AlarmAddDataSource{
  factory AlarmAddDataSource(
    Dio dio,
  {String baseUrl}
) = _AlarmAddDataSource;
  @POST()
  Future<AlarmAddRequestModel> addAlarmGroup(
      @Body() AlarmGroups
      );
}