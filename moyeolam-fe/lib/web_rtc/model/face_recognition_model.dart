import 'package:json_annotation/json_annotation.dart';

part 'face_recognition_model.g.dart';

@JsonSerializable()
class ResponseFaceRecognitionModel {
  int code;
  String message;
  FaceRecognitionResultModel data;

  ResponseFaceRecognitionModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ResponseFaceRecognitionModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseFaceRecognitionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseFaceRecognitionModelToJson(this);
}

@JsonSerializable()
class FaceRecognitionResultModel {
  bool result;
  double confidence;

  FaceRecognitionResultModel(this.result, this.confidence);

  factory FaceRecognitionResultModel.fromJson(Map<String, dynamic> json) =>
      _$FaceRecognitionResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$FaceRecognitionResultModelToJson(this);
}
