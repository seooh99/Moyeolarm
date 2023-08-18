// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final fcmProvider = Provider.of<FcmProvider>(context);
//
//     // 알림 유형에 따라 다이얼로그 띄우기
//     if (fcmProvider.latestMessage?.data['notificationType'] == '친구 요청') {
//       WidgetsBinding.instance?.addPostFrameCallback((_) {
//         _showFriendRequestDialog(context);
//       });
//     }
//     // 다른 알림 유형에 따른 처리도 여기에 추가
//
//     return Scaffold(
//       // ... 나머지 코드
//     );
//   }
//
//   void _showFriendRequestDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) => AlertDialog(
//         title: Text('친구 요청'),
//         content: Text('친구 요청을 수락하시겠습니까?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('취소'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               // 친구 요청 수락 로직
//             },
//             child: Text('확인'),
//           ),
//         ],
//       ),
//     );
//   }
// }
