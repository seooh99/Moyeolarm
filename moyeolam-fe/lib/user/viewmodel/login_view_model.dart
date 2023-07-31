// import 'package:provider/provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/user_model.dart';
import '../repository/user_repository.dart';

final userProvider = StateProvider((ref) => UserViewModel());
UserRepository _userRepository = UserRepository();

class UserViewModel extends StateNotifier<User> {
  UserViewModel() : super(User(null));
  var nickname;

  void login() async {
    try {
      var usr = await _userRepository.getUserList();
      print("${usr.toString()} API user data");
      // usr = null;  // nickname == null test
      if (usr != null) {
        nickname = usr.nickname.toString();
        print("$nickname nickname is not null");
        // context.go(name);
        print("going main page");
        // Navigator.push(context, MaterialPageRoute(builder: builder))
      } else {
        print("going setting nickname page");
      }
    } catch (error) {
      print(error);
    }

    // return usr!;
  }

  String setNickname(newNickname) {
    nickname = newNickname;
    return nickname;
  }

  // late final UserRepository _userRepository;
  // List<User> _userList = List.empty(growable: true);
  // List<User> get userList => _userList;

  // UserViewModel() {
  //   _userRepository = UserRepository();
  //   _getUserList();
  // }

  // Future<void> _getUserList() async {
  //   _userList = await _userRepository.getUserList();
  //   print(_userList);
  //   notifyListeners();
  // }

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
