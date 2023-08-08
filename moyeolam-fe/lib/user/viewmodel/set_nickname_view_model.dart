import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:youngjun/user/repository/user_repository.dart';

FlutterSecureStorage storage = FlutterSecureStorage();
// final nicknameProvider = StateNotifierProvider((ref) => NicknameViewModel(''));

class NicknameViewModel {
  late String nName;
  UserNicknameRepository _nicknameRepository = UserNicknameRepository();

  void setNickname(String newNickname) {
    nName = newNickname;
  }

  apiNickname() async {
    try {
      var userInfo = await storage
          .read(key: 'userInfo')
          .then((value) => jsonDecode(value!));
      print("$userInfo 토큰 닉넴뷰모델");
      var response= await _nicknameRepository
          .updateNickname(
        nName,
        userInfo["accessToken"],
      )
          .then((value) {
            print("${value.code} 나는 코드");
            return value.code;
        // if (value.code == "200") {
        //   print("${value.code} nickname view model");
        //   userInfo["nickname"] = nName;
        //   await storage.write(key: "userInfo", value: jsonEncode(userInfo));
        //   print("write storage in setnickname view model");
        //   return 'accept';
        // } else if (value.code == "603") {
        //   return 'false';
        // }
      });
      return response;
    } catch (e) {
      print("$e setNickNameError");
    }
  }
}
