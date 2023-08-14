import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:youngjun/kakao/kakao_login.dart';
import 'package:youngjun/kakao/main_view_model.dart';
import 'package:youngjun/main.dart';
import 'package:youngjun/main/view/main_page.dart';
import 'package:youngjun/user/model/user_model.dart';
import '../../firebase_options.dart';
import '../repository/user_repository.dart';



class AuthViewModel {
  final UserRepository _userRepository = UserRepository();
  final kakaoViewModel = MainViewModel(KakaoLogin());
  UserInformation _userInformation = UserInformation(storage);
  dynamic userInfo;

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  late String deviceIndentifier;

  login() async {
    try {
      var kakaoLogin = await kakaoViewModel.login();
      // print("$kakaoLogin 카카오로그인 auth 뷰모델");

      // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
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
        print("${rawResponse.data} 심기불편");

        var response = rawResponse.data;
        // await storage.write(key: "userInfo", value: jsonEncode(response));
        _userInformation.setUserInfo(response);
        // print(await storage.readAll());
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
      UserModel? storageData = await _userInformation.getUserInfo();
      if(storageData != null) {
        await _userRepository.signOut(storageData.accessToken).then((value) {
          print("$value 회원탈퇴 auth view model");
        });
        await _userInformation.deletUserInfo();
      }
    } catch (e) {
      print("$e signOut error in authViewmodel");
    }
  }
}

// class UserViewModel extends StateNotifier<User> {
//   UserViewModel() : super(User(null));
//   static const storage = FlutterSecureStorage();
//   // User user = User(null);
//   dynamic userInfo = '';

//   login() async {
//     var response = await _userRepository.getUserList();

//     if (response == null) {
//       print(" response error ");
//       return "apiError";
//     } else if (response.nickname != null) {
//       var val = jsonEncode(User('${response.nickname}'));
//       await storage.write(
//         key: "userInfo",
//         value: val,
//       );
//       return 'main';
//     } else {
//       // 닉네임창으로 보내기
//       return 'signin';
//     }
//   }

//   logout() async {
//     await storage.delete(key: "userInfo");
//     // 로그인창으로  ㄱ
//   }

//   checkUserState() async {}

//   isLogin() async {
//     userInfo = await storage.read(key: 'userInfo');

//     if (userInfo != null) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   // Future<String> login() async {
//   //   try {
//   //     var usr = await _userRepository.getUserList();
//   //     // print("${usr.toString()} API user data");
//   //     // usr!.nickname = null; // nickname == null test
//   //     if (usr!.nickname != null) {
//   //       // nickname = usr.nickname.toString();
//   //       user.nickname = usr.nickname.toString();
//   //       state = user;
//   //       print("${state.nickname.toString()} 1234");
//   //       print("${user.nickname} nickname is not null");
//   //       print("going main page");
//   //       return "main";
//   //     } else {
//   //       print("going setting nickname page");
//   //       return "signin";
//   //     }
//   //   } catch (error) {
//   //     print(error);
//   //     return "false";
//   //   }
//   // }

//   // String setNickname(newNickname) {
//   //   user.nickname = newNickname;
//   //   return user.nickname.toString();
//   // }

//   // late final UserRepository _userRepository;
//   // List<User> _userList = List.empty(growable: true);
//   // List<User> get userList => _userList;

//   // UserViewModel() {
//   //   _userRepository = UserRepository();
//   //   _getUserList();
//   // }

//   // Future<void> _getUserList() async {
//   //   _userList = await _userRepository.getUserList();
//   //   print(_userList);
//   //   notifyListeners();
//   // }

//   // void addData(int newUserId, int newOauthType, String newOauthIndex,
//   //     String newFcmToken, String newNickname, DateTime newSignDate) {
//   //   this._userId = newUserId;
//   //   this._oauthType = newOauthType;
//   //   this._oauthIndex = newOauthIndex;
//   //   this._fcmToken = newFcmToken;
//   //   this._nickname = newNickname;
//   //   this._signDate = newSignDate;
//   // }

//   // void updateData(String newNickname) {
//   //   this._nickname = newNickname;
//   // }
// }
