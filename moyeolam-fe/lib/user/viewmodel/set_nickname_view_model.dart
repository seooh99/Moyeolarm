import 'dart:convert';

import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:youngjun/main.dart';
import 'package:youngjun/user/model/user_model.dart';
import 'package:youngjun/user/repository/user_repository.dart';


class NicknameViewModel {
  final UserInformation _userInformation = UserInformation(storage);
  String nName = '';
  final UserNicknameRepository _nicknameRepository = UserNicknameRepository();

  void setNickname(String newNickname) {
    nName = newNickname;
  }

  apiNickname() async {
    try {
      UserModel? userInfo = await _userInformation.getUserInfo();
      // print("$userInfo 토큰 닉넴뷰모델");
      print("$nName nickname");
      if (userInfo != null) {
        var response = await _nicknameRepository
            .updateNickname(
          nName,
          userInfo.accessToken,
        )
            .then((value) {
          // print("${value.code} 나는 코드");
          return value.code;
        });
        return response;
      }
    } catch (e) {
      print("$e setNickNameError");
    }
  }
}
