
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/repository/add_friend_alarm_group_repository.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:youngjun/friends/model/friends_list_model.dart';
import 'package:youngjun/friends/repository/friends_repository.dart';
import 'package:youngjun/main.dart';
import 'package:youngjun/user/model/user_model.dart';

AddFriendAlarmGroupViewModel _addFriendAlarmGroupViewModel = AddFriendAlarmGroupViewModel();
final addFriendAlarmProvider = ChangeNotifierProvider<AddFriendAlarmGroupViewModel>((ref) => _addFriendAlarmGroupViewModel );
//
// final searchFriendProvider = FutureProvider<List<Friend>?>((ref) async {
//   return await _addFriendAlarmGroupViewModel.searchFriend();
// } );

class AddFriendAlarmGroupViewModel extends ChangeNotifier{
  // final List<int?> memberIds = [];
  // final List<String?> member = [];
  final List<AddMemberModel?> members = [];
  final AddFriendAlarmGroupRepository _addFriendAlarmGroupRepository = AddFriendAlarmGroupRepository();
  final List<int?> checkId = [];
  // final FriendsRepository _friendsRepository = FriendsRepository(Dio());
  UserInformation _userInformation = UserInformation(storage);
  String friendNickname = '';

  clearMember(){
    members.clear();
  }

  setMember(int newMemberId, String newMemberNickname){
    if(!checkId.contains(newMemberId)){
      AddMemberModel newMember = AddMemberModel(
          nickname: newMemberNickname,
          memberId: newMemberId,
      );
      checkId.add(newMemberId);
      members.add(newMember);
    }
    notifyListeners();
  }

  setFriendNickname(String Nickname) {
    friendNickname = Nickname;
  }

  deleteMember(AddMemberModel member){
    if(checkId.contains(member.memberId)){
      checkId.remove(member.memberId);
      members.remove(member);
    }
    notifyListeners();
  }

  inviteFriend(int alarmGroupId, List<int?> memberIds) async {
    UserModel? userInfo = await _userInformation.getUserInfo();
    String token = "Bearer ${userInfo!.accessToken}";
    return await _addFriendAlarmGroupRepository.inviteFriend(token, alarmGroupId, memberIds);
  }

  // Future<List<Friend>?> searchFriend() async {
  //   print("$friendNickname friend");
  //   UserModel? userInfo = await _userInformation.getUserInfo();
  //   String token = "Bearer ${userInfo!.accessToken}";
  //   var response =  await _friendsRepository.searchFriends(token, friendNickname);
  //   if(response.code == "200"){
  //     return response.data.friends;
  //   }
  //   return null;
  // }
}

class AddMemberModel {
  final String nickname;
  final int memberId;

  AddMemberModel({
    required this.nickname,
    required this.memberId,
});
}