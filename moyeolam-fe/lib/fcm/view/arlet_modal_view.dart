import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/fcm/api/strategies/group_accept_strategy.dart';

import '../api/arlet_modal_api.dart';
import '../api/strategies/group_accept_strategy.dart';

class APIDialog extends StatelessWidget {
  const APIDialog({
    Key? key,
    required this.acceptOnPressed,
    required this.declineOnPressed,
    required this.fromNickname,
    required this.titleList,
    required this.alertTypeList,
    required this.alarmGroupId,
    required this.friendRequestId,
  }) : super(key: key);

  final VoidCallback acceptOnPressed;
  final VoidCallback declineOnPressed;
  final String fromNickname;
  final String titleList;
  final String alertTypeList;
  final String alarmGroupId;
  final String friendRequestId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '$fromNickname님의 $alertTypeList',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '수락하시겠습니까?',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      actions: <Widget>[
        if (alertTypeList == '친구 수락' ||
            alertTypeList == '알람그룹 수락' ||
            alertTypeList == '알람그룹 탈퇴' ||
            alertTypeList == '알람그룹 강퇴')
          TextButton(
            onPressed: () {},
            child: Text(
              '확인',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MAIN_COLOR,
              ),
            ),
          )
        else
          TextButton(
            onPressed: () {
              if (alertTypeList == '친구 요청') {
                ArletModalApi().handleApiRequest('친구 요청', friendRequestId: friendRequestId, userWantsToAccept: false,);
              } else {
                ArletModalApi().handleApiRequest('알람그룹 요청', alarmGroupId: alarmGroupId, userWantsToAccept: false);
              }
              Navigator.of(context).pop(); // Dialog 닫기
            },
            child: Text(
              '거절',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: CKECK_GRAY_COLOR,
              ),
            ),
          ),
        if (alertTypeList == '친구 수락' ||
            alertTypeList == '알람그룹 수락' ||
            alertTypeList == '알람그룹 탈퇴' ||
            alertTypeList == '알람그룹 강퇴')
          Container()
        else
          TextButton(
            onPressed: () {
              if (alertTypeList == '친구 요청') {
                ArletModalApi().handleApiRequest('친구 요청', friendRequestId: friendRequestId, userWantsToAccept: true);
              } else {
                ArletModalApi().handleApiRequest('알람그룹 요청', alarmGroupId: alarmGroupId, userWantsToAccept: true);
              }
              Navigator.of(context).pop(); // Dialog 닫기
            },
            child: Text(
              '수락',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MAIN_COLOR,
              ),
            ),
          ),
      ],
    );
  }
}
