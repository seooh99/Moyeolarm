import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:youngjun/kakao/kakao_login.dart';
import 'package:youngjun/kakao/login.dart';
// import 'package:youngjun/user/model/user_model.dart';

class MainViewModel {
  final KakaoLogin _socialLogin;
  bool isLogined = false;
  // KakaoUser? user;
  MainViewModel(this._socialLogin);

  Future login() async {
    isLogined = await _socialLogin.login();
    if(isLogined){
      // 유저정보 가져오기
      User user = await UserApi.instance.me();
      print("$user 메인뷰모델 유저");
      return user;
    }
  }

  Future logout() async {
    await _socialLogin.logout();
    isLogined = false;
    // user = null;
  }
}