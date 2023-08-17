
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moyeolam/friends/model/friends_list_model.dart';
import 'package:moyeolam/friends/repository/friends_repository.dart';

FriendSearchViewModel _friendSearchViewModel = FriendSearchViewModel();
FriendRepository _friendRepository = FriendRepository();

final friendSearchProvider = FutureProvider((ref) => _friendSearchViewModel.searchMyFriends());
final friendSearchNotifierProvider = ChangeNotifierProvider((ref) => _friendSearchViewModel);

class FriendSearchViewModel extends ChangeNotifier{
  String _keyword = '';

  String get keyword => _keyword;
  setKeyword(String newKeyword){
    _keyword = newKeyword;
    notifyListeners();
  }

  // 친구 검색
  Future<List<FriendModel?>?> searchMyFriends() async{
    var response = await _friendRepository.searchMyFriends(_keyword);
      // print("check api request code: ${response.code} data: ${response.data.friends[0]!.nickname}");
    if(response.code == "200"){
      return response.data.friends;
    }
    print("Error: searchMyFriends code is ${response.code}");
  }
}