import 'package:dio/dio.dart';
import 'package:moyeolam/main.dart';
import '../../../common/const/address_config.dart';
import 'package:moyeolam/fcm/data_source/fcm_api_data_source.dart';
import '../../common/secure_storage/secure_storage.dart';
import '../../user/model/user_model.dart';
import '../model/alert_service_model.dart';

class FriendAcceptStrategy {
  final FcmApiService _apiService;
  final UserInformation _userInformation = UserInformation(storage);

  FriendAcceptStrategy(this._apiService);

  Future<void> execute(bool isAccepted, int friendRequestId) async {
    try {
      // UserInformation을 사용하여 accessToken 가져오기
      UserModel? userInfo = await _userInformation.getUserInfo();
      if (userInfo == null) {
        print("User info not found.");
        return;
      }
      String token = "Bearer ${userInfo.accessToken}";

      // ApiArletModel에서 데이터 가져오기 (토큰 포함하여)
      ApiArletModel? alertResponse = await _apiService.getPosts(token);

      if (alertResponse != null) {
        print('API 데이터 가져오기 성공');
        print('Response Data: ${alertResponse}');

        await handleFriendRequest(isAccepted, friendRequestId, token);
      } else {
        print('API 데이터 가져오기 실패');
      }
    } catch (e) {
      print('API 요청 예외: $e');
    }
  }

  Future<void> handleFriendRequest(bool isAccepted, int friendRequestId, String token) async {
    try {
      ApiArletModel? response;
      if (isAccepted) {
        response = await _apiService.postFriendAccept(token, friendRequestId);
      } else {
        response = await _apiService.postFriendDecline(token, friendRequestId);
      }

      if (response != null) {
        print('${isAccepted ? "수락" : "거절"} API 요청 성공');
        print('응답 데이터: ${response}');
      } else {
        print('${isAccepted ? "수락" : "거절"} API 요청 실패');
      }
    } catch (e) {
      print('친구${isAccepted ? "수락" : "거절"} API 요청 예외 발생: $e');
    }
  }
}
