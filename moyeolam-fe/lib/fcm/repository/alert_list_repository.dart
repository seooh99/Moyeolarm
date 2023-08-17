import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moyeolam/alarm/data_source/alarm_detail_data_source.dart';
import 'package:moyeolam/common/const/address_config.dart';
import 'package:moyeolam/common/secure_storage/secure_storage.dart';
import 'package:moyeolam/main.dart';
import 'package:moyeolam/user/model/user_model.dart';

import '../data_source/fcm_api_data_source.dart';
import '../model/alert_service_model.dart';


class AlertListRepository {
  final UserInformation _userInformation;
  final FcmApiService _alertListDataSource;

  AlertListRepository()
      : _userInformation = UserInformation(FlutterSecureStorage()),
        _alertListDataSource = FcmApiService(Dio(), baseUrl: BASE_URL);

  // Future<UserModel> getAlertList() async {
  //   UserModel? userInfo = await _userInformation.getUserInfo();
  //   String token = "Bearer ${userInfo!.accessToken}";
  //   return _alertListDataSource.getAlertList(token);
  // }


  // Future<ApiArletModel> deleteArListGroup() async {
  //   UserModel? userInfo = await _userInformation.getUserInfo();
  //   String token = "Bearer ${userInfo!.accessToken}";
  //   return _alertListDataSource.deleteArListGroup(token);
  // }
  //



}