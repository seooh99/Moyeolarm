import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../common/const/address_config.dart';
import '../model/setting_model.dart';

part 'setting_service.g.dart';

@RestApi()
abstract class SettingService {
  factory SettingService(Dio dio, {String baseUrl}) = _SettingService;

  @GET('/member/settings')
  Future<FetchSettingModel?> getSettings(
      @Header("Authorization") String token,
      );


  @PATCH('/member/settings/notification-toggle')
  Future<ChangeSettingModel?> patchSettings(
      @Header("Authorization") String token,
      @Query('data') bool data);
}