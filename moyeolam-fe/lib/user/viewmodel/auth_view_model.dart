import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  dynamic userInfo;
  AuthViewModel() {
    var logined = isLogin();
    if (logined == true) {
      userInfo = storage.read(key: 'userInfo');
    } else {
      login().then((res) {
        print("$res 나는 뷰모델");
      });
    }
  }

  isLogin() async {
    // userInfo = await storage.read(key: 'userInfo');

    if (userInfo != null) {
      // print("isLo");
      return true;
    } else {
      // print("not lg");
      return false;
    }
  }

  login() async {
    try {
      var response = await _userRepository.getUserList();
      // print(response);

      // return response!.nickname != null ? "main" : "sigin";
      // if (response != null) {
      //   print(" error: null");
      //   return "false";
      // } else
      if (response!.nickname != null) {
        // print(response.nickname);
        await storage.write(key: "userInfo", value: jsonEncode(response));
        // storage.deleteAll();
        // print(await storage.read(key: "userInfo"));
        return "main";
      } else if (response.nickname == null) {
        // print("sigin");
        return 'signin';
      } else {
        return "false";
      }
    } catch (e) {
      // print("$e 1234");
      return "$e";
    }
  }
}
