
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ApiGroupPostModel {
  String? code;
  String? message;
  int data;

  ApiGroupPostModel({
    this.code,
    this.message,
    required this.data,
  });

  factory ApiGroupPostModel.fromJson(Map<String, dynamic> json) {
    return ApiGroupPostModel(
      code: json['code'],
      message: json['message'],
      data: json['data'],
    );
  }

  @override
  String toString() {
    return 'ApiGroupPostModel(code: $code, message: $message, data: $data)';
  }
}
