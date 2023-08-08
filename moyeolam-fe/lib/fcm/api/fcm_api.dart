import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:youngjun/main.dart';

import '../view/arlet_list_view.dart';

import 'package:youngjun/main/view/settings.dart';


import 'package:dio/dio.dart';

Future<bool> fetchNotificationStatus() async {
  final dio = Dio();
  try {
    final response = await dio.get('API 주소');
    if (response.statusCode == 200) {
      return response.data['notificationStatus'];
    } else {
      throw Exception('Failed to fetch notification status');
    }
  } catch (error) {
    print('Error fetching notification status: $error');
    throw Exception('Failed to fetch notification status');
  }
}

void handleMessage(RemoteMessage? message, bool notificationStatus) {
  if (!notificationStatus) {
    return;
  }

  if (message != null && message.notification != null) {
    Navigator.of(navigatorKey.currentContext!).pushNamed(
      ArletListView.route,
      arguments: message,
    );
  }
}

Future<void> initLocalNotifications() async {
  const android = AndroidInitializationSettings('drawable/ic_launcher');
  const setting = InitializationSettings(android: android);

  final FlutterLocalNotificationsPlugin _localNotification = FlutterLocalNotificationsPlugin();

  await FlutterLocalNotificationsPlugin().initialize(
    setting,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      final payload = response.payload ?? '';
      final parsedJson = jsonDecode(payload);
      if (parsedJson.containsKey('routeTo') && parsedJson['routeTo'] == '/arlet_list') {


      }
    },
  );

  final platform = _localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  await platform?.createNotificationChannel(AndroidNotificationChannel(
    'my_notification_channel',
    'My Notification Channel',
    importance: Importance.high,
  ));
}


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print(message.notification?.body);
  initPushNotifications();

}



Future<void> initPushNotifications() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // 알림 설정 상태를 가져와서 handleMessage 함수에 전달
  bool notificationStatus = await fetchNotificationStatus();

  FirebaseMessaging.instance.getInitialMessage().then((message) {
    handleMessage(message, notificationStatus); // 앱이 백그라운드에서 열렸을 때 처리하는 함수 호출
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    handleMessage(message, notificationStatus); // 앱이 백그라운드 상태에서 푸시 알림을 눌렀을 때 처리하는 함수 호출

  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  initLocalNotifications();



}



class FirebaseApi with ChangeNotifier {
  final _firebaseMessaging = FirebaseMessaging.instance;
  // String? fcmToken;

  RemoteMessage? latestMessage; // 수신한 마지막 메시지 저장

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();
    print('Token:  $fcmToken');
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      latestMessage = message; // 메시지 저장
      notifyListeners(); // 변경 알림
    });

    notifyListeners();
    initPushNotifications();
    initLocalNotifications();
  }

}
