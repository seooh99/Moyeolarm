// final alarmListProvider = FutureProvider<List<AlarmGroups>?>((ref) async {
//   final dio = Dio();
//   final alarms = AlarmListRepository(dio);
//
//   return await alarms.getAlarmList().then((value) => value.data.alarmGroups);
// });

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/friends/repository/friends_list_repository.dart';

import '../model/friends_list_model.dart';

final friendsListProvider = FutureProvider<List<Friend>?>((ref) async{

  final dio = Dio();
  final friends = FriendsListRepository(dio);

  return await friends.getFriendsList().then((value) => value.data.friends);

});
