import 'package:youngjun/fcm/service/friend_accept_strategy.dart';
import 'package:youngjun/fcm/service/group_accept_strategy.dart';

import '../../common/secure_storage/secure_storage.dart';

class ArletModalApi {
  final UserInformation _userInformation;

  // 생성자에서 UserInformation 초기화
  ArletModalApi(this._userInformation);
  void handleApiRequest(String alertType,
      {
        int? fromMemberId,
        int? alarmGroupId,
        int? friendRequestId,
        required bool isAccepted}) {
    if (alertType == '친구 요청') {
      if (isAccepted) {
        FriendAcceptStrategy().ApproveFriend(true, friendRequestId!);
      } else {
        FriendAcceptStrategy().DeclineFriend(false, friendRequestId!);
      }
    } else if (alertType == '알람그룹 요청') {
      if (fromMemberId != null) {
        if (isAccepted) {
          GroupAcceptStrategy(_userInformation).execute(alarmGroupId!, true, fromMemberId);
        } else {
          GroupAcceptStrategy(_userInformation).execute(alarmGroupId!, false, fromMemberId);
        }
      } else {
        print('fromUserId 가 널!!!');
      }
    }
  }
}
