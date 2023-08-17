import 'package:dio/dio.dart' hide Headers;
import 'package:moyeolam/web_rtc/model/face_recognition_model.dart';

class FaceRecognitionDataSource {
  FaceRecognitionDataSource(
    this.dio, {
    this.baseUrl,
  });

  final Dio dio;
  String? baseUrl;

  Future<ResponseFaceRecognitionModel> faceRecognition(image) async {
    final data = FormData.fromMap({
      'image': image,
    });

    final result = await dio.get(
      '$baseUrl/recognition/face/',
      data: data,
    );

    final value = ResponseFaceRecognitionModel.fromJson(result.data!);

    print("result: ${value.data.result}");
    print("confidence: ${value.data.confidence}");

    return value;
  }
}
