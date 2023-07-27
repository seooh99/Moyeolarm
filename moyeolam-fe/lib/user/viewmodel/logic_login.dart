import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youngjun/provider/model/model_user.dart';
import 'package:http/http.dart' as http;

const String url = "http://70.12.247.72:8080/oauth2/authorization/kakao";

Future<String> getInfo() async{
    try {
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        // final List<User> user = userFromJson(response.body);
        // return user;
        print("Ok");
        return "OK";
      }else{
        Fluttertoast.showToast(msg: 'Error ocuured. Please try again');
        // return <User> [];
        print("Not Ok;");
        return "Not Ok;";
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
      // return <User> [];
      print("Not Ok;");
      return "Not Ok;";
    }
}
