import 'package:dio/dio.dart';
import 'package:youngjun/common/const/address_config.dart';
import 'package:youngjun/web_rtc/data_source/face_recognition_data_source.dart';

import '../model/face_recognition_model.dart';

class FaceRecognitionRepository {
  final FaceRecognitionDataSource _faceRecognitionDataSource =
      FaceRecognitionDataSource(Dio(), baseUrl: RECOGNITION_URL);

  Future<ResponseFaceRecognitionModel> faceRecognition(MultipartFile image) {
    return _faceRecognitionDataSource.faceRecognition(image);
  }
}
