import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/fcm/service/alert_main_sevice.dart';
import 'package:youngjun/friends/model/friends_list_model.dart';
import 'package:youngjun/friends/repository/friends_repository.dart';

FriendRepository _friendRepository = FriendRepository();
FriendListViewModel _friendsListResponseModel = FriendListViewModel();
final friendListProvider = FutureProvider((ref) => _friendsListResponseModel.getFriendsList());



class FriendListViewModel {

  // 전체 조회
  Future<List<FriendModel?>?> getFriendsList() async {
    var response = await _friendRepository.getFriendsList();
    if (response.code == "200"){
      return response.data.friends;
    }
  }


  // 친구 삭제
  Future<void> deleteFriend(int myFriendId) async {
    var response = await _friendRepository.deleteFriend(myFriendId);
    if (response.code == "200"){
      print("Delete Friend $myFriendId Ok");
    } else{
      print("Error: Delete Friend code: ${response.code}");
    }

  }

}