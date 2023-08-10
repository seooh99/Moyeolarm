import 'package:json_annotation/json_annotation.dart';

part 'arlet_service_model.g.dart';

@JsonSerializable()
class ApiArletModel {
  String? code; // 에러 코드
  String? message; // 에러 메시지
  ApiArletData? data; // 실제 데이터

  ApiArletModel({
    this.code,
    this.message,
    this.data,
  });

  factory ApiArletModel.fromJson(Map<String, dynamic> json) {
    return ApiArletModel(
      code: json['code'],
      message: json['message'],
      data: ApiArletData.fromJson(json['data']),
    );
  }
}
@JsonSerializable()
class ApiArletData {
  List<ApiArletItem>? alerts;

  ApiArletData({
    this.alerts,
  });

  factory ApiArletData.fromJson(Map<String, dynamic> json) {
    return ApiArletData(
      alerts: (json['alerts'] as List<dynamic>?)?.map((e) => ApiArletItem.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}


@JsonSerializable()
class ApiArletItem {
  String? fromNickname;
  String? title;
  String? time;
  String? alertType;
  String? createAt;

  ApiArletItem({
    this.fromNickname,
    this.title,
    this.time,
    this.alertType,
    this.createAt,
  });

  factory ApiArletItem.fromJson(Map<String, dynamic> json) {
    return ApiArletItem(
      fromNickname: json['fromNickname'] as String?,
      title: json['title'] as String?,
      time: json['time'] as String?,
      alertType: json['alertType'] as String?,
      createAt: json['createAt'] as String?,
    );
  }
}


