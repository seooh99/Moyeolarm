
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/alarm/repository/add_friend_alarm_group_repository.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:youngjun/friends/model/friends_list_model.dart';
import 'package:youngjun/friends/repository/friends_repository.dart';
import 'package:youngjun/main.dart';
import 'package:youngjun/user/model/user_model.dart';



class AddFriendAlarmGroupViewModel extends ChangeNotifier{
  final List<AddMemberModel?> members = [];
  final AddFriendAlarmGroupRepository _addFriendAlarmGroupRepository = AddFriendAlarmGroupRepository();
  final List<int?> checkId = [];

  String friendNickname = '';

  clearMember(){
    members.clear();
    notifyListeners();
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
    notifyListeners();
  }

  deleteMember(AddMemberModel member){
    if(checkId.contains(member.memberId)){
      checkId.remove(member.memberId);
      members.remove(member);
    }
    notifyListeners();
  }

  inviteFriend(int alarmGroupId, List<int?> memberIds) async {

    return await _addFriendAlarmGroupRepository.inviteFriend(alarmGroupId, memberIds);
  }

}

class AddMemberModel {
  final String nickname;
  final int memberId;

  AddMemberModel({
    required this.nickname,
    required this.memberId,
});
}