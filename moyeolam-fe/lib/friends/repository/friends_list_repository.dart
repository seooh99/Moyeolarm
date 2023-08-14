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


import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:youngjun/common/const/address_config.dart';

import '../model/friends_list_model.dart';

part 'friends_list_repository.g.dart';

final friendsListRepositoryProvider = Provider((ref){

  final dio = Dio();

  final repository = FriendsListRepository(dio, baseUrl: '$BASE_URL/friends');

  return repository;

});

@RestApi(baseUrl: BASE_URL)
abstract class FriendsListRepository{

  factory FriendsListRepository(Dio dio, {String baseUrl}) = _FriendsListRepository;

  @GET('/friends')
  Future<FriendsListModel> getFriendsList(
    @Header('Authorization') String token,
  );



}