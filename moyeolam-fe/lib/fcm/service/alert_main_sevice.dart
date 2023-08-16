
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';

import 'package:youngjun/fcm/model/alert_service_model.dart';
import 'package:youngjun/main.dart';
import 'package:youngjun/user/model/user_model.dart';

import '../data_source/fcm_api_data_source.dart';

import 'package:flutter/cupertino.dart';


class AlertService with ChangeNotifier {
  final UserInformation userInformation; // Future를 제거
  ApiArletModel? alertData;

  AlertService(this.userInformation);

  Future<ApiArletModel> fetchData() async {
    try {
      final apiService = FcmApiService(Dio());
      UserModel? userInfo = await userInformation.getUserInfo();
      String token = "Bearer ${userInfo!.accessToken}";
      final response = await apiService.getPosts(token);

      // 원시 응답 로그 추가
      print('API 원시 응답: ${response.toString()}');

      if (response != null) {
        alertData = response;
        print('데이터 가져오는 중...');
      } else {
        print('null값임!');
        alertData = null;
      }
      notifyListeners();
      if (alertData == null) {
        throw Exception("API에서 데이터 가져오기 실패");
      }
      return alertData!;
    } on DioError catch (e) {
      print('DioError 발생: $e');
      throw Exception("API에서 데이터 가져오기 실패");
    } catch (e) {
      print('기타 에러 발생~~~: $e');
      throw e;
    }
  }
}

