import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:youngjun/main.dart';


// @pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print(message.notification?.body);

}


class FcmProvider with ChangeNotifier {
  final _firebaseMessaging = FirebaseMessaging.instance;
  // String? fcmToken;

  RemoteMessage? latestMessage; // 수신한 마지막 메시지 저장

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();
    print('Token:  $fcmToken');
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    // FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
    //   // save token to server
    // });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // 여기에 특정 페이지로 이동하는 로직을 정의
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (context) => YourTargetPage()),
      // );

      latestMessage = message; // 메시지 저장
      notifyListeners(); // 변경 알림
    });

    // FirebaseMessaging.instance.deleteToken();

    notifyListeners();
  }

// Further FCM methods can go here
}
