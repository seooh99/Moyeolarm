// final alarmListProvider = FutureProvider<List<AlarmGroups>?>((ref) async {
//   final dio = Dio();
//   final alarms = AlarmListRepository(dio);
//
//   return await alarms.getAlarmList().then((value) => value.data.alarmGroups);
// });

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:youngjun/friends/repository/friends_list_repository.dart';
import 'package:youngjun/main.dart';
import 'package:youngjun/user/model/user_model.dart';

import '../model/friends_list_model.dart';

final friendsListProvider = FutureProvider<List<Friend>?>((ref) async{

  final dio = Dio();
  final friends = FriendsListRepository(dio);
  UserInformation _userInformation = UserInformation(storage);
  UserModel? userInfo = await _userInformation.getUserInfo();
  String token = "Bearer ${userInfo!.accessToken}";
  return await friends.getFriendsList(token)
      .then((value) => value.data.friends);

});
