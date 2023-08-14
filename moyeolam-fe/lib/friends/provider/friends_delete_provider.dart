

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:youngjun/friends/provider/friends_list_provider.dart';
import 'package:youngjun/main.dart';
import 'package:youngjun/user/model/user_model.dart';

import '../model/friends_list_model.dart';
import '../repository/friends_repository.dart';
import 'friends_search_provider.dart';

// final friendsDeleteProvider = FutureProvider<void>((ref) async {
//   final dio = Dio();
//   final friends = FriendsRepository(dio);
//
//   final myFriendId = ref.read(friendsSearchProvider).value?.first.memberId;
//
//   if (myFriendId != null) {
//     return await friends.deleteFriend(myFriendId);
//   }
//   return ;
//
// });
UserInformation _userInformation = UserInformation(storage);

class FriendsDeleteNotifier {
  final FriendsRepository friendsRepository = FriendsRepository(Dio());


  FriendsDeleteNotifier();

  Future<void> removeFriend(Friend friend) async {
    UserModel? userInfo = await _userInformation.getUserInfo();
    String token = "Bearer ${userInfo!.accessToken}";
    await friendsRepository.deleteFriend(
      token,
      friend.memberId,
    );
  }
}