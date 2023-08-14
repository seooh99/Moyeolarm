import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:youngjun/main.dart';
import 'package:youngjun/user/model/user_model.dart';
import 'package:youngjun/user/repository/user_repository.dart';

// FlutterSecureStorage storage = FlutterSecureStorage();
// final nicknameProvider = StateNotifierProvider((ref) => NicknameViewModel(''));

class NicknameViewModel {
  UserInformation _userInformation = UserInformation(storage);
  late String nName;
  UserNicknameRepository _nicknameRepository = UserNicknameRepository();

  void setNickname(String newNickname) {
    nName = newNickname;
  }

  apiNickname() async {
    try {
      UserModel? userInfo = await _userInformation.getUserInfo();
      print("$userInfo 토큰 닉넴뷰모델");
      String token = "Bearer ${userInfo!.accessToken}";
      if (userInfo != null) {
        var response = await _nicknameRepository
            .updateNickname(
          nName,
          userInfo!.accessToken,
        )
            .then((value) {
          print("${value.code} 나는 코드");
          return value.code;
        });
        return response;
      }
    } catch (e) {
      print("$e setNickNameError");
    }
  }
}
