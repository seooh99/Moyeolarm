import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:youngjun/user/repository/user_repository.dart';
import '../model/user_model.dart';


// final nicknameProvider = StateNotifierProvider((ref) => NicknameViewModel(''));

class NicknameViewModel  {
  // static const storage = FlutterSecureStorage();
  // NicknameViewModel() : super(User.fromJson(userInfo));
  String nName='';

  // NicknameViewModel(String nName): super(nName ?? '');
  UserNicknameRepository _nicknameRepository = UserNicknameRepository();

  // void setNickname(String newNickname) {
  //   state = state.copyWith(nickname: newNickname);
  // }

  void setNickname(String newNickname) {
    // var userInfo = await storage.read(key: "useInfo");
    // print("$userInfo 닉네임 설정 view model");
    // userInfo =  userInfo;
    nName = newNickname;

    // state = newNickname;

    // print(nName);
  }

  void apiNickname(){
    _nicknameRepository.updateNickname(nName);
  }
}

// extension UserCopyWithExtension on User {
//   User copyWith({String? nickname}) {
//     return User(nickname ?? this.nickname);
//   }
// }
