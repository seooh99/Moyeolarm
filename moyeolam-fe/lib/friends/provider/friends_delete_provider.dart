

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/friends/provider/friends_list_provider.dart';

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

class FriendsDeleteNotifier {
  final FriendsRepository friendsRepository = FriendsRepository(Dio());


  FriendsDeleteNotifier();

  Future<void> removeFriend(Friend friend) async {
    await friendsRepository.deleteFriend(friend.memberId);
  }
}