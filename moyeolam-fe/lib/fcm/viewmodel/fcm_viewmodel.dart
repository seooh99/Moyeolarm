import 'package:youngjun/fcm/api/fcm_api.dart';


import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:provider/provider.dart';
// import 'package:youngjun/fcm/provider/fcm_provider.dart';

class FcmViewModel {
  final FirebaseApi _fcmProvider;

  FcmViewModel(this._fcmProvider);

  void configureFcm() {
    _fcmProvider.initNotifications();
  }

  // void _onFcmUpdate() {
  //   // Provider에서 변경을 감지하면 이 메소드가 호출됨
  //   // 필요한 로직을 여기에 추가하거나, View에 직접 전달
  // }

 // FCM 공급자와 인터페이스하는 추가
}
