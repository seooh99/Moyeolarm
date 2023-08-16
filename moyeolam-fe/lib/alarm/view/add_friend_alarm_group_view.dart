// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:youngjun/alarm/viewmodel/add_friend_alarm_group_view_model.dart';
// import 'package:youngjun/common/button/btn_back.dart';
// import 'package:youngjun/common/button/btn_save_update.dart';
// import 'package:youngjun/common/const/colors.dart';
// import 'package:youngjun/common/layout/title_bar.dart';
// import 'package:youngjun/common/secure_storage/secure_storage.dart';
// import 'package:youngjun/common/textfield_bar.dart';
// // import 'package:youngjun/friends/provider/friends_list_provider.dart';
// import 'package:youngjun/friends/model/friends_list_model.dart';
// import 'package:youngjun/user/model/user_search_model.dart';
//
// class AddFriendAlarmGroupView extends ConsumerStatefulWidget{
//   final List<MemberModel?> invitedMember;
//   final int alarmGroupId;
//   const AddFriendAlarmGroupView({
//     super.key,
//     required this.invitedMember,
//     required this.alarmGroupId,
//   });
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _AddFriendAlarmGroupViewState(
//     alarmGroupId: alarmGroupId,
//     invitedMember: invitedMember,
//   );
//
// }
//
// class _AddFriendAlarmGroupViewState extends ConsumerState{
//   late final AddFriendAlarmGroupViewModel _addFriendAlarmGroupViewModel;
//
//   final TextEditingController _searchFriend = TextEditingController();
//
//   final List<MemberModel?> invitedMember;
//   final int alarmGroupId;
//
//   _AddFriendAlarmGroupViewState({
//     required this.invitedMember,
//     required this.alarmGroupId,
//   });
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _searchFriend.dispose();
//     super.dispose();
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     if(invitedMember.isNotEmpty) {
//       ref.read(addFriendAlarmProvider).clearMember();
//       for (int index = 1; index < invitedMember.length; index++) {
//           ref.read(addFriendAlarmProvider).setMember(
//             invitedMember[index]!.memberId, invitedMember[index]!.nickname);
//       }
//     }
//     _addFriendAlarmGroupViewModel = AddFriendAlarmGroupViewModel();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     var addFriend = ref.watch(addFriendAlarmProvider);
//     List<MemberModel?> members = addFriend.members;
//
//     AsyncValue<List<Friend>?> searchedFriends = ref.watch(searchFriendProvider);
//     AsyncValue<List<Friend>?> friends = ref.watch(friendsListProvider);
//     return Scaffold(
//       backgroundColor: BACKGROUND_COLOR,
//       appBar: TitleBar(
//           appBar: AppBar(),
//           title: "친구 초대",
//         leading: BtnBack(
//           onPressed: (){
//             Navigator.of(context).pop();
//           }
//         ),
//         actions: [
//           BtnSaveUpdate(
//               onPressed: () async {
//                 await _addFriendAlarmGroupViewModel.inviteFriend(alarmGroupId, addFriend.checkId);
//                 Navigator.of(context).pop();
//               },
//               text: "초대",
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 100,
//             width: double.infinity,
//             // child: Text("텍스트 필드창"),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: TextFieldbox(
//                 controller: _searchFriend,
//                 // setContents: AddFriendAlarmGroupViewModel().setFriendNickname,
//                 setContents: (String value){
//                   _searchFriend.text = value;
//                   addFriend.setFriendNickname(_searchFriend.text);
//                 },
//                 onChange: () {
//                   ref.invalidate(searchFriendProvider);
//                 },
//                 suffixIcon: Icon(Icons.search),
//                 suffixIconColor: FONT_COLOR,
//               ),
//             ),
//           ),
//
//           Container(
//             height: 60,
//             width: double.infinity,
//             // child: Text("초대할 친구 목록 창"),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   for (var member in members)
//                     Container(
//                       padding: const EdgeInsets.only(left: 4, right: 4),
//                       child: ActionChip(
//                         backgroundColor: MAIN_COLOR,
//                           avatar: const Icon(Icons.remove),
//                           label: Text("${member?.nickname}"),
//                           onPressed: () {
//                             ref.read(addFriendAlarmProvider).deleteMember(member!);
//                           },
//                     ),
//                     )
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(left: 32, right: 32, top: 32),
//             width: double.infinity,
//
//             // child: Text("친구 목록"),
//             child: ( searchedFriends??friends).when(
//               data: (data){
//
//                     return SingleChildScrollView(
//                       child: Column(
//                         children: [
//                       // for (var friend in friends)
//                       // for(int index=0;i
//                       // if (data)
//                         for (Friend friend in data!)
//                           ListTile(
//                             onTap: () {
//                               print("${friend.memberId} invite view");
//                               ref
//                                   .read(addFriendAlarmProvider)
//                                   .setMember(friend.memberId, friend.nickname);
//                             },
//                             title: Text(friend!.nickname),
//                             contentPadding: EdgeInsets.only(top: 12),
//                             leading: Icon(Icons.add, color: FONT_COLOR),
//                             titleTextStyle: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 20),
//                           // selected: true,
//                           // selectedTileColor: ,
//                         ),
//                     ],
//                   ),
//                   //    child: ListView.builder(
//                   //      // padding: EdgeInsets.all(1),
//                   //      itemCount: data?.length,
//                   //        itemBuilder: (context, index) {
//                   //            return ListTile(
//                   //              onTap: (){},
//                   //              selected: true,
//                   //
//                   //              selectedColor: Colors.grey,
//                   //              // title: Text(data![index].nickname),
//                   //              title: Text("test"),
//                   //            );
//                   //        },
//                   //    )
//                 );
//
//             },
//                       error: (error, stackTrace){
//                         print("Error: $error 123");
//                         return const SpinKitFadingCube(
//                         // FadingCube 모양 사용
//                         color: Colors.blue, // 색상 설정
//                         size: 50.0, // 크기 설정
//                         duration: Duration(seconds: 2), //속도 설정
//                         );
//                       },
//                       loading: (){
//                         return const SpinKitFadingCube(
//                           // FadingCube 모양 사용
//                           color: Colors.blue, // 색상 설정
//                           size: 50.0, // 크기 설정
//                           duration: Duration(seconds: 2), //속도 설정
//                         );
//                       }
//                   ),
//                 ),
//             ]
//       )
//     );
//   }
//
// }
