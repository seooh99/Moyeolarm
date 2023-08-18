import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moyeolam/friends/repository/friends_repository.dart';
import 'package:moyeolam/user/model/user_search_model.dart';
import 'package:moyeolam/user/repository/user_repository.dart';

FriendRepository _friendRepository = FriendRepository();
UserRepository _userRepository = UserRepository();

FriendAddViewModel friendAddViewModel = FriendAddViewModel();

final memberSearchProvider = FutureProvider((ref) async {
  print("future provider called");
  return await friendAddViewModel.searchMember();
});
final memberSearchSettingProvider = ChangeNotifierProvider((ref) => friendAddViewModel);

class FriendAddViewModel extends ChangeNotifier{
  String _keyword = '';

  setKeyword(String newKeyword) {
    _keyword = newKeyword;
    print("addFriend keyword : $_keyword");
    notifyListeners();
  }

  // 회원 검색
  Future<MemberModel?> searchMember() async {
    print("is searhcMemb");
    var response = await _userRepository.searchMember(_keyword);
    print("search member code: ${response.code}");
    if (response.code == "200"){
      print("member Search data: ${response.data}");
      return response.data;
    }
    return null;
  }

  // 친구 요청
  Future<bool> makeFriend(int memberId) async {
    var response = await _friendRepository.makeFriend(memberId);
    if (response.code == "200"){
      print("Request Ok memberId = ${response.data}");
      return true;
    }else{
      print("Error: makeFriend Error code is ${response.code}");
      return false;
    }
  }
}