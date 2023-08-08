import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:youngjun/alarm/model/alarm_detail_model.dart';
import 'package:youngjun/alarm/model/alarm_list_model.dart';
import 'package:youngjun/common/const/data.dart';

import '../../common/const/address_config.dart';

part 'alarm_detail_repository.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class AlarmDetailRepository {
  factory AlarmDetailRepository(Dio dio, {String baseUrl}) =
  _AlarmDetailRepository;

  @GET('/alarmgroups/{alarmGroupId}')
  Future<AlarmGroupModel> getAlarmGroupDetail(@Path('alarmGroupId') int alarmGroupId);
}
