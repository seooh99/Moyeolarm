import 'package:youngjun/fcm/api/strategies/friend_accept_strategy.dart';
import 'package:youngjun/fcm/api/strategies/group_accept_strategy.dart';

class ArletModalApi {
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
          GroupAcceptStrategy().execute(alarmGroupId!, true, fromMemberId);
        } else {
          GroupAcceptStrategy().execute(alarmGroupId!, false, fromMemberId);
        }
      } else {
        print('fromUserId 가 널!!!');
      }
    }
    // 나머지 alertType에 따른 스트래티지 처리
  }
}
