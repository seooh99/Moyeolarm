import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:youngjun/common/const/address_config.dart';

import '../data_source/user_data_source.dart';
import 'package:youngjun/user/model/user_model.dart';

class UserRepository {
  final UserDataSource _userDataSource = UserDataSource(
    Dio(),
    baseUrl: BASE_URL,
  );

  Future<Map<String, UserModel>> isSigned(String request) {
    print("$request repository");
    IsSigned params = IsSigned(oauthIdentifier: request);
    // print(params.oauthIdentifier);
    return _userDataSource.isSigned(params);
  }
}

class UserNicknameRepository{
  final UserDataSource _dataSource = UserDataSource(Dio(), baseUrl: BASE_URL);

  Future<Map<String, dynamic>> updateNickname(String newNickname){
    NicknamePost params = NicknamePost(nickname: newNickname);
    return _dataSource.updateNickname(params);
  }
}
