import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:youngjun/kakao/kakao_login.dart';
import 'package:youngjun/kakao/main_view_model.dart';
import 'package:youngjun/main/view/main_page.dart';
import 'package:youngjun/user/model/user_model.dart';
import '../../firebase_options.dart';
import '../repository/user_repository.dart';



class AuthViewModel {
  final UserRepository _userRepository = UserRepository();
  final kakaoViewModel = MainViewModel(KakaoLogin());
  UserInformation _userInformation = UserInformation();
  dynamic userInfo;

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  late String deviceIndentifier;

  login() async {
    try {
      var kakaoLogin = await kakaoViewModel.login();
      // print("$kakaoLogin 카카오로그인 auth 뷰모델");

      final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
      WidgetsFlutterBinding.ensureInitialized();

      var fcmToken = await FirebaseMessaging.instance.getToken().then((token) {
        print('FCM Token: $token'); // FCM 토큰을 터미널에 출력
        return token;
      });
      print("hi");

      AndroidDeviceInfo androidData = await deviceInfoPlugin.androidInfo;
      deviceIndentifier = androidData.id;

      if(kakaoLogin != null && fcmToken != null && deviceIndentifier != null) {
        var rawResponse =
        await _userRepository.isSigned(
          kakaoLogin.id.toString(),
          fcmToken,
          deviceIndentifier
        );


        var response = rawResponse.data;
        // await storage.write(key: "userInfo", value: jsonEncode(response));
        _userInformation.setUserInfo(response);

        if (response.nickname != null) {
          print(response.nickname);
          // print(await storage.read(key: "userInfo"));
          return "main";
        } else {
          // var userInfo = await storage.read(key: 'userInfo');
          var userInfo = await _userInformation.getUserInfo();
          print("$userInfo sigin");
          return 'signin';
        }
      }else{
        print("Error KakaoLogin or FcmToken or DeviceIdentifier is null");
      }
    } catch (e) {
      print("$e auth_view_model_error");
      return "false";
    }
  }

  logOut() async {
    try {
      await _userInformation.deletUserInfo();

      print("logOut in auth view model");
    } catch (e) {
      print("$e logOut error in auth view model");
    }
  }

  signOut() async {
    try {
      var storageData = await _userInformation.getUserInfo();

      await _userRepository.signOut(storageData!.accessToken).then((value) {
        print("$value 회원탈퇴 auth view model");
        logOut();
      }).catchError((error){
        print("Error: signout $error");
      });

    } catch (e) {
      print("$e signOut error in authViewmodel");
    }
  }
}
