import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import '../model/user_model.dart';

part 'user_data_source.g.dart';

@RestApi()
abstract class UserDataSource {
  factory UserDataSource(Dio dio, {String baseUrl}) = _UserDataSource;

  // @Headers(<String, String>{
  //   "accessToken": "true",
  //   'refreshToken': "true",
  // })
  @GET('/loginSuccess')
  Future<User>? getUser();
}
