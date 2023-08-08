import 'dart:convert';
import '../model/nickname_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import '../model/nickname_model.dart';
import '../model/user_model.dart';

part 'user_data_source.g.dart';

@RestApi()
abstract class UserDataSource {
  factory UserDataSource(Dio dio, {String baseUrl}) = _UserDataSource;

  @POST('/login')
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
  })
  Future<ResponseUserModel> isSigned(
    @Body() IsSigned params,
  );

  @POST("/member/nickname")
  Future<NicknameResposne> updateNickname(
    @Body() NicknamePost nickname,
    @Header('Authorization') String token,
  );

  @DELETE("/member")
  Future<NicknameResposne> signOut(
    @Header('Authorization') String token,
  );
}
