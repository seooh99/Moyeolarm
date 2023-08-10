import 'package:youngjun/fcm/api/strategies/friend_accept_strategy.dart';
import 'package:youngjun/fcm/api/strategies/group_accept_strategy.dart';

class ArletModalApi {
  void handleApiRequest(String alertType, {int? fromUserId, String? alarmGroupId, String? friendRequestId, required bool userWantsToAccept}) {
    if (alertType == '친구 요청') {
      if (userWantsToAccept) {
        FriendAcceptStrategy().ApproveFriend(friendRequestId!);
      } else {
        FriendAcceptStrategy().DeclineFriend(friendRequestId!);
      }
    } else if (alertType == '알람그룹 요청') {
      if (fromUserId != null) {
        if (userWantsToAccept) {
          GroupAcceptStrategy().execute(alarmGroupId!, true, fromUserId);
        } else {
          GroupAcceptStrategy().execute(alarmGroupId!, false, fromUserId);
        }
      } else {
        print('fromUserId is null, cannot process the request');
      }
    }
    // 나머지 alertType에 따른 스트래티지 처리
  }
}
