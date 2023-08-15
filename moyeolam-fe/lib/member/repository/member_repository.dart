
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:youngjun/common/const/address_config.dart';

import '../model/member_model.dart';


part 'member_repository.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class MemberRepository {
  factory MemberRepository(Dio dio, {String baseUrl}) =
  _MemberRepository;
  
  @GET('/member')
  Future<MemberModel> searchMember(
      @Header('Authorization') String token,
      @Query('keyword') String keyword,
      );
}