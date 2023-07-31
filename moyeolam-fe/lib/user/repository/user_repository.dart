import 'package:dio/dio.dart';
import 'package:youngjun/common/const/address_config.dart';

import '../data_source/user_data_source.dart';
import 'package:youngjun/user/model/user_model.dart';

class UserRepository {
  final UserDataSource _userDataSource = UserDataSource(
    Dio(),
    baseUrl: BASE_URL,
  );

  Future<User>? getUserList() {
    return _userDataSource.getUser();
  }
}
