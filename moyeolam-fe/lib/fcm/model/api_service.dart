import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';


part 'api_service.g.dart';


@JsonSerializable()
class ResponseData {
  final String code;
  final String message;
  final List<Alert> alerts;

  ResponseData({required this.code, required this.message, required this.alerts});

  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}

@JsonSerializable()
class Alert {
  final String fromNickname;
  final String alertType;

  Alert({required this.fromNickname, required this.alertType});

  factory Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);
  Map<String, dynamic> toJson() => _$AlertToJson(this);
}

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/alerts')
  Future<ResponseData> getAlerts();
}
