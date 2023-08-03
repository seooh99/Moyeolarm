import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../model/api_service.dart';
import '../view/arlet_list_view.dart';
import 'package:youngjun/fcm/model/api_service.dart' as modelApi;
// Provider 정의...


final notificationsProvider = FutureProvider<List<modelApi.Alert>>((ref) async {
  final dio = Dio(); // Dio 객체 설정
  final apiService = modelApi.ApiService(dio);

  final response = await apiService.getAlerts(); // 메서드가 ApiService 내에서 정의되어 있어야 함
  return response.alerts;
});


