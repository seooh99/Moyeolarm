// final alarmListProvider = FutureProvider<List<AlarmGroups>?>((ref) async {
//   final dio = Dio();
//   final alarms = AlarmListRepository(dio);
//
//   return await alarms.getAlarmList().then((value) => value.data.alarmGroups);
// });

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:youngjun/friends/model/friends_list_model.dart';
import 'package:youngjun/main.dart';
import 'package:youngjun/user/model/user_model.dart';
import '../repository/friends_repository.dart';

UserInformation _userInformation = UserInformation(storage);

final friendsSearchProvider = FutureProvider<List<Friend>?>((ref) async {
  final dio = Dio();
  final friends = FriendsRepository(dio);
  UserModel? userInfo = await _userInformation.getUserInfo();
  String token = "Bearer ${userInfo!.accessToken}";
  final friendsSearchModel =
      await friends.searchFriends(
          token,
          '',
      ).catchError((error) {
    // 에러 처리 로직 추가
    print('Error: $error');
    return FriendsListModel(
        code: '',
        message: '',
        data: Data(friends: [])); // 에러 발생 시 빈 모델 반환 또는 알맞은 처리
  });

  return friendsSearchModel.data.friends;
});
