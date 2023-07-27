import 'package:fluttertoast/fluttertoast.dart';

import 'package:youngjun/data/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserDataSource {
  static const String url =
      "http://70.12.247.72:8080/oauth2/authorization/kakao";

  Future<List<User>> getUser() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<User> user = userFromJson(response.body);
        print("Ok");

        return user;
      } else {
        Fluttertoast.showToast(msg: 'Error ocuured. Please try again');
        // return <User> [];
        print("Not Ok;");

        return <User>[];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      // return <User> [];
      print("Not Ok;");
      return <User>[];
    }
  }
}
