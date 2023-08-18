import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:moyeolam/kakao/login.dart';

class KakaoLogin {
  @override
  Future<bool> login() async {
    try{
      bool isInstalled = await isKakaoTalkInstalled();
      if(isInstalled){
        try{
          await UserApi.instance.loginWithKakaoTalk();
          return true;
        }
        catch(error){
          print("$error 안녕 2");
          return false;
        }
      }else{
        try{
          await UserApi.instance.loginWithKakaoAccount();
          return true;
        }catch(error){
          print("$error 안녕 3");
          return false;
        }
      }
    }catch(error){
      print("$error 안녕 4");
      return false;
    }
  }

  @override
  Future<bool> logout()  async{
    try {
      await UserApi.instance.unlink();
      return true;
    }catch(error) {
      return false;
    }

  }

}