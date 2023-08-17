import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:youngjun/common/const/address_config.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:youngjun/main.dart';
import 'package:youngjun/user/model/nickname_model.dart';
import 'package:youngjun/user/model/user_search_model.dart';
import '../data_source/user_data_source.dart';
import 'package:youngjun/user/model/user_model.dart';



class UserRepository {
  UserInformation _userInformation = UserInformation(storage);
  final UserDataSource _userDataSource = UserDataSource(
    Dio(BaseOptions(baseUrl: BASE_URL)),
    baseUrl: BASE_URL,
  );
  // 회원 조회
  Future<UserSearchResponseModel> searchMember(String keyword) async{
    UserModel? userInfo = await _userInformation.getUserInfo();
    String token = "Bearer ${userInfo!.accessToken}";
    return await _userDataSource.searchMember(token, keyword);
  }
  // 회원가입 여부 확인(초기 로그인)
  Future<ResponseUserModel> isSigned(String request, String fcmToken, String deviceIdentifier) {
    // print("$request repository");
    IsSigned params = IsSigned(
      oauthIdentifier: request,
      fcmToken: fcmToken,
      deviceIdentifier: deviceIdentifier,
    );
    // print(params.oauthIdentifier);
    return _userDataSource.isSigned(params);
  }
  // 회원 탈퇴
  Future<NicknameResponse> signOut(String token) {
    // print("sign out user repository");
    return _userDataSource.signOut('Bearer $token');
  }
}

class UserNicknameRepository {
  final UserDataSource _dataSource = UserDataSource(Dio(), baseUrl: BASE_URL);

  Future<NicknameResponse> updateNickname(String newNickname, String token) {
    NicknamePost params = NicknamePost(nickname: newNickname);
    return _dataSource.updateNickname(
      params,
      'Bearer $token',
    );
  }
}
