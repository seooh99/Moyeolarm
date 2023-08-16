import 'package:dio/dio.dart';
import 'package:youngjun/common/const/address_config.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:youngjun/friends/data_source/friend_data_source.dart';
import 'package:youngjun/friends/model/friend_delete_model.dart';
import 'package:youngjun/friends/model/friends_add_model.dart';
import 'package:youngjun/friends/model/friends_list_model.dart';
import 'package:youngjun/friends/model/friends_search_model.dart';
import 'package:youngjun/main.dart';
import 'package:youngjun/user/model/user_model.dart';



class FriendRepository {
  UserInformation _userInformation = UserInformation(storage);
  FriendDataSource _friendDataSource = FriendDataSource(
    Dio(),
    baseUrl: BASE_URL,
  );

  // 친구 전체 조회
  Future<FriendsListResponseModel> getFriendsList() async {
    UserModel? userInfo = await _userInformation.getUserInfo();
    String token = "Bearer ${userInfo!.accessToken}";
    return await _friendDataSource.getFriendsList(token);
  }

  //친구 요청
  Future<FriendsAddResponseModel> makeFriend(int memberId) async{
    UserModel? userInfo = await _userInformation.getUserInfo();
    String token = "Bearer ${userInfo!.accessToken}";
    return await _friendDataSource.friendRequestPost(token, memberId);
  }

  // 친구 검색
  Future<FriendsSearchResponseModel> searchMyFriends(String keyword) async {
    UserModel? userInfo = await _userInformation.getUserInfo();
    String token = "Bearer ${userInfo!.accessToken}";
    return await _friendDataSource.searchFriends(token, keyword);
  }

  // 친구 삭제
  Future<FriendsDeleteResponseModel> deleteFriend(int myFriendId) async {
    UserModel? userInfo = await _userInformation.getUserInfo();
    String token = "Bearer ${userInfo!.accessToken}";
    return await _friendDataSource.deleteFriend(token, myFriendId);
  }

}