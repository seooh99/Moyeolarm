import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:youngjun/kakao/kakao_login.dart';
import 'package:youngjun/kakao/main_view_model.dart';
import 'package:youngjun/user/model/user_model.dart';
import '../repository/user_repository.dart';

// final userProvider =

// class AuthViewModel extends StatefulWidget {
//   const AuthViewModel({super.key});

//   @override
//   State<AuthViewModel> createState() => _AuthViewModelState();
// }

class AuthViewModel {
  final UserRepository _userRepository = UserRepository();
  static const storage = FlutterSecureStorage();
  final kakaoViewModel = MainViewModel(KakaoLogin());
  dynamic userInfo;

  // AuthViewModel() {
  //
  //
  //
  // }

  isLogin() async {
    // userInfo = await storage.read(key: 'userInfo');
    userInfo = await storage.read(key: 'userInfo');
    if (userInfo != null) {
      print("isLogin true");
      return true;
    } else {
      print("isLogin false");
      return false;
    }
  }

  login() async {
    try {
      var kakaoLogin = await kakaoViewModel.login();
      // print("$kakaoLogin 카카오로그인 auth 뷰모델");

      var rawResponse =
          await _userRepository.isSigned(kakaoLogin.id.toString());
      // print("${rawResponse.data} 심기불편");

      var response = rawResponse.data;
      await storage.write(key: "userInfo", value: jsonEncode(response));
      print(await storage.readAll());
      if (response.nickname != null) {
        print(response.nickname);
        // print(await storage.read(key: "userInfo"));
        return "main";
      } else {
        var userInfo = await storage.read(key: 'userInfo');
        print("$userInfo sigin");
        return 'signin';
      }
    } catch (e) {
      print("$e auth_view_model_error");
      return "false";
    }
  }

  logOut() async {
    try {
      await storage.delete(key: 'userInfo');
      print("logOut in auth view model");
    } catch (e) {
      print("$e logOut error in auth view model");
    }
  }

  signOut() async {
    try {
      var userInfo = await storage
          .read(key: 'userInfo')
          .then((value) => jsonDecode(value!));
      var token = userInfo["accessToken"];
      await _userRepository.signOut(token).then((value) {
        print("$value 회원탈퇴 auth view model");
      });
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
