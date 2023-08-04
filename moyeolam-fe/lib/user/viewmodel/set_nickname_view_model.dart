import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/user_model.dart';

final userProvider = StateNotifierProvider((ref) => NicknameViewModel());

class NicknameViewModel extends StateNotifier<User> {
  NicknameViewModel() : super(User(''));
  String nName = '';
  // void setNickname(String newNickname) {
  //   state = state.copyWith(nickname: newNickname);
  // }

  void setNickname(String newNickname) {
    nName = newNickname;
    // print(nName);
  }
}

extension UserCopyWithExtension on User {
  User copyWith({String? nickname}) {
    return User(nickname ?? this.nickname);
  }
}
