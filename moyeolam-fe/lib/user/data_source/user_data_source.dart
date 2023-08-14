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
  Future<ResponseUserModel> isSigned(
    @Body() IsSigned params,
  );

  @POST("/member/nickname")
  Future<NicknameResponse> updateNickname(
    @Body() NicknamePost nickname,
    @Header('Authorization') String token,
  );

  @DELETE("/member")
  Future<NicknameResponse> signOut(
    @Header('Authorization') String token,
  );
}
