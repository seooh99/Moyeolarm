import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../common/const/address_config.dart';
import '../model/setting_model.dart';

part 'setting_service.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class SettingService {
  factory SettingService(Dio dio, {String baseUrl}) = _SettingService;

  @GET('/member/settings')
  Future<FetchSettingModel?> getSettings();


  @PATCH('/member/settings/notification-toggle')
  Future<ChangeSettingModel?> patchSettings(@Query('data') bool data);
}