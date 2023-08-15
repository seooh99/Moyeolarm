import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';

import '../../common/secure_storage/secure_storage.dart';
import '../api/alert_modal_api.dart';


class APIDialog extends StatelessWidget {
  final UserInformation _userInformation;
  const APIDialog({
    Key? key,
    required this.acceptOnPressed,
    required this.declineOnPressed,
    required this.fromNickname,
    required this.titleList,
    required this.alertTypeList,
    this.alarmGroupId,
    this.friendRequestId,
    required this.fromMemberId,
    required UserInformation userInformation,  // 생성자에 UserInformation 인자를 추가
  })  : _userInformation = userInformation,  // 초기화
        super(key: key);

  final VoidCallback acceptOnPressed;
  final VoidCallback declineOnPressed;
  final String fromNickname;
  final String titleList;
  final String alertTypeList;
  final int? alarmGroupId;
  final int? friendRequestId;
  final int fromMemberId;



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
              if (alertTypeList == '친구 요청' ) {
                ArletModalApi(_userInformation).handleApiRequest('친구 요청',
                    friendRequestId: friendRequestId,
                    isAccepted: false,
                    fromMemberId: fromMemberId);
              } else if (fromMemberId != null) {
                ArletModalApi(_userInformation).handleApiRequest('알람그룹 요청',
                    alarmGroupId: alarmGroupId,
                    isAccepted: false,
                    fromMemberId: fromMemberId);
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
                ArletModalApi(_userInformation).handleApiRequest('친구 요청',
                    friendRequestId: friendRequestId,
                    isAccepted: true,
                    fromMemberId: fromMemberId);
              } else if (fromMemberId != null) {
                ArletModalApi(_userInformation).handleApiRequest('알람그룹 요청',
                    alarmGroupId: alarmGroupId,
                    isAccepted: true,
                    fromMemberId: fromMemberId);
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
