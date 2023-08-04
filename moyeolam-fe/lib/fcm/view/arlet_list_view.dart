import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:youngjun/fcm/model/api_service.dart' as modelApi;
part 'arlet_list_view.g.dart';


@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/alerts")
  Future<ResponseData> fetchNotifications();
}


@JsonSerializable()
class ResponseData {
  final String code;
  final String message;
  final List<MyNotification> alerts;

  ResponseData({required this.code, required this.message, required this.alerts});

  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);
}

@JsonSerializable()
class MyNotification {
  final String fromNickname;
  final String alertType;

  MyNotification({required this.fromNickname, required this.alertType});

  factory MyNotification.fromJson(Map<String, dynamic> json) => _$MyNotificationFromJson(json);
}


final notificationsProvider = FutureProvider<List<MyNotification>>((ref) async {
  final dio = Dio(); // Dio 객체 설정
  final apiService = ApiService(dio);

  final response = await apiService.fetchNotifications();
  return response.alerts;
});


class NotificationsList extends ConsumerWidget {
  const NotificationsList({super.key});

  String getMessage(MyNotification notification) {
    // 메시지 처리 부분, null을 반환하지 않고 항상 String을 반환해야 함
    // 예를 들어:
    return 'Some message based on notification';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsyncValue = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: notificationsAsyncValue.when(
        data: (notifications) => ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(getMessage(notifications[index])),
            );
          },
        ),
        loading: () => CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
      ),
    );
  }
}
