import 'package:dio/dio.dart';
import 'package:youngjun/alarm/data_source/alarm_detail_data_source.dart';
import 'package:youngjun/common/const/address_config.dart';

import '../model/alarm_detail_model.dart';
import '../model/alarm_list_model.dart';

class AlarmListRepository {
  final AlarmListDataSource _alarmListDataSource = AlarmListDataSource(
    Dio(),
    baseUrl: BASE_URL,
  );

  Future<AlarmListResponseModel> getAlarmList() {
    return _alarmListDataSource.getAlarmList();
  }

  Future<AlarmDetailResponseModel> getAlarmListDetail(int alarmGroupId) {
    print("alarmGroupId: ${alarmGroupId}");
    return _alarmListDataSource.getAlarmDetail(alarmGroupId);
  }
}





//
//
// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:retrofit/retrofit.dart';
// import 'package:youngjun/alarm/model/alarm_list_model.dart';
// import 'package:youngjun/common/const/data.dart';
//
// import '../../common/const/address_config.dart';
//
// part 'alarm_list_repository.g.dart';
//
//
// final alarmRepositoryProvider = Provider<AlarmListRepository>((ref){
//
//   final dio = Dio();
//
//   final repository = AlarmListRepository(dio, baseUrl: '$BASE_URL/alarmgroups');
//
//   return repository;
//
// });
//
// @RestApi(baseUrl: 'http://i9a502.p.ssafy.io:8080')
// abstract class AlarmListRepository {
//
//
//   // http://i9a502.p.ssafy.io:8080
//   factory AlarmListRepository(Dio dio, {String baseUrl}) =
//   _AlarmListRepository;
//
//   @GET('/alarmgroups')
//   Future<AlarmListModel> getAlarmList();
//
//
// // http://i9a502.p.ssafy.io:8080/alarmgroups
// // @GET('/alarmgroups')
// // Future<Map<String, List<AlarmListModel>>> getAlarmList(
// //     @Query("alarmGroupId") int alarmGroupId,
// //     @Query("title") int title,
// //     @Query("hour") String hour,
// //     @Query("minute") int minute,
// //     @Query("dayOfWeek") List<bool> dayOfWeek,
// //     @Query("isLock") bool isLock,
// //     @Query("toggle") bool toggle,
// //     );
//
//
//
// }
