import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:youngjun/common/const/address_config.dart';
import 'package:youngjun/data/model/user_model.dart';
import 'package:dio/dio.dart';

class UserDataSource {
  static const String url = "${BASE_URL}loginSuccess";

  Future<List<User>> getUser() async {
    var dio = Dio();
    try {
      var response = await dio.get(url);
      print(response);
      if (response.statusCode == 200) {
        final List<User> user = response.data;
        print("Ok");

        return user;
      } else {
        Fluttertoast.showToast(msg: 'Error ocuured. Please try again');
        // return <User> [];
        print("${response.statusCode}");

        return <User>[];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      // return <User> [];
      print(e);

      print("Not Ok;");
      return <User>[];
    }
  }
}
