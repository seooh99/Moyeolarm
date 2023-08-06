import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/user_model.dart';

// final userProvider = StateNotifierProvider((ref) => NicknameViewModel());


class NicknameViewModel {
  static const storage = FlutterSecureStorage();
  // NicknameViewModel() : super(User.fromJson(userInfo));
  // String nName = '';
  // void setNickname(String newNickname) {
  //   state = state.copyWith(nickname: newNickname);
  // }

  void setNickname(String newNickname) async{
    var userInfo = await storage.read(key: "useInfo");
    print("$userInfo 닉네임 설정 view model");
    // userInfo =  userInfo;
     // = newNickname;
    // print(nName);
  }
}

// extension UserCopyWithExtension on User {
//   User copyWith({String? nickname}) {
//     return User(nickname ?? this.nickname);
//   }
// }
