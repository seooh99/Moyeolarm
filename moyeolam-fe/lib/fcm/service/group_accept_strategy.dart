import 'package:dio/dio.dart';
import 'package:youngjun/common/const/address_config.dart';

import '../../common/secure_storage/secure_storage.dart';
import '../../user/model/user_model.dart';
import '../data_source/fcm_api_data_source.dart';
import '../model/alert_service_model.dart';

class GroupAcceptStrategy {
  final FcmApiService _apiService;
  final UserInformation _userInformation;

  GroupAcceptStrategy(this._apiService, this._userInformation);

  Future<void> execute(bool isAccepted, int alarmGroupId, [int? fromMemberId]) async {
    try {
      UserModel? userInfo = await _userInformation.getUserInfo();
      if (userInfo == null) {
        print("User info not found.");
        return;
      }
      String token = "Bearer ${userInfo.accessToken}";
      int memberId = userInfo.memberId;

      ApiArletModel? alertResponse = await _apiService.getPosts(token);

      if (alertResponse != null) {
        print('API 데이터 가져오기 성공');
        print('Response Data: ${alertResponse}');

        await handleGroupRequest(isAccepted, alarmGroupId, token, memberId, fromMemberId);
      } else {
        print('API 데이터 가져오기 실패');
      }
    } catch (e) {
      print('API 요청 예외: $e');
    }

  }

  Future<void> handleGroupRequest(bool isAccepted, int alarmGroupId, String token, int memberId, [int? fromMemberId]) async {
    try {
      var data = {
        "fromMemberId": fromMemberId,
        "toMemberId": memberId,
      };
      ApiArletModel? response;

      if (isAccepted) {
        response = await _apiService.postGroupAccept(token, alarmGroupId, data);
      } else {
        response = await _apiService.postGroupDecline(token, alarmGroupId, data);
      }

      if (response != null) {
        print('${isAccepted ? "수락" : "거절"} API 요청 성공');
        print('응답 데이터: ${response}');
      } else {
        print('${isAccepted ? "수락" : "거절"} API 요청 실패');
      }
    } catch (e) {
      print('${isAccepted ? "수락" : "거절"} API 요청 예외 발생: $e');
    }
  }
}
