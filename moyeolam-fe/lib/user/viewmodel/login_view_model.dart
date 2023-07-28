import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import 'package:youngjun/data/model/user_model.dart';
import 'package:youngjun/data/repository/user_repository.dart';

class UserViewModel with ChangeNotifier {
  late final UserRepository _userRepository;
  List<User> _userList = List.empty(growable: true);
  List<User> get userList => _userList;

  UserViewModel() {
    _userRepository = UserRepository();
    _getUserList();
  }

  Future<void> _getUserList() async {
    _userList = await _userRepository.getUserList();
    print(_userList);
    notifyListeners();
  }

  // void addData(int newUserId, int newOauthType, String newOauthIndex,
  //     String newFcmToken, String newNickname, DateTime newSignDate) {
  //   this._userId = newUserId;
  //   this._oauthType = newOauthType;
  //   this._oauthIndex = newOauthIndex;
  //   this._fcmToken = newFcmToken;
  //   this._nickname = newNickname;
  //   this._signDate = newSignDate;
  // }

  // void updateData(String newNickname) {
  //   this._nickname = newNickname;
  // }
}
