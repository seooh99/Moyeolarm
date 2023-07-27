import '../data_source/user_data_source.dart';
import 'package:youngjun/data/model/user_model.dart';

class UserRepository {
  final UserDataSource _userDataSource = UserDataSource();

  Future<List<User>> getUserList() {
    return _userDataSource.getUser();
  }
}
