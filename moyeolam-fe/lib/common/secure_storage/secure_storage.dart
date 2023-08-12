import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:youngjun/user/model/user_model.dart';

FlutterSecureStorage storage = FlutterSecureStorage();

class UserInformation {
  getUserInfo() async {
    var stringUserInfo = await storage.read(key: 'userInfo');
    if(stringUserInfo !=null){
      var result = jsonDecode(stringUserInfo);
      print("${result["nickname"]}");
      return result;
    }else{
      print("Erorr: userInfo is $stringUserInfo");
    }
  }

  setUserInfo(UserModel newUserInfo) async {
    var stringUserInfo = jsonEncode(newUserInfo);
    await storage.write(key: 'userInfo', value: stringUserInfo);
    var result = await storage.read(key: 'userInfo');
    print("updated userInfo is $result");
  }

  deletUserInfo() async {
    await storage.delete(key: 'userInfo');
    print("Delete!");
    return "Delete UserInforamtion";
  }
}