import 'package:moyeolam/fcm/service/friend_accept_strategy.dart';
import 'package:moyeolam/fcm/service/group_accept_strategy.dart';

import '../../common/secure_storage/secure_storage.dart';
import '../data_source/fcm_api_data_source.dart';

class ArletModalApi {
  final FcmApiService _fcmApiService;

  // 생성자에서 UserInformation과 FcmApiService 초기화
  ArletModalApi(this._fcmApiService);
  void handleApiRequest(String alertType,
      {
        int? fromMemberId,
        int? alarmGroupId,
        int? friendRequestId,
        required bool isAccepted}) {
    if (alertType == '친구 요청') {
      final strategy = FriendAcceptStrategy(_fcmApiService);
      if (isAccepted) {
        strategy.execute(true, friendRequestId!);
      } else {
        strategy.execute(false, friendRequestId!);
      }
    } else if (alertType == '알람그룹 요청') {
      final strategy = GroupAcceptStrategy(_fcmApiService);
      if (isAccepted) {
        strategy.execute(true, alarmGroupId!);
      } else {
        strategy.execute(false, alarmGroupId!);
      }
    }
  }
}
