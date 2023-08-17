import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moyeolam/alarm/viewmodel/add_friend_alarm_group_view_model.dart';
import 'package:moyeolam/common/button/btn_back.dart';
import 'package:moyeolam/common/button/btn_save_update.dart';
import 'package:moyeolam/common/const/colors.dart';
import 'package:moyeolam/common/layout/title_bar.dart';
import 'package:moyeolam/common/secure_storage/secure_storage.dart';
import 'package:moyeolam/common/textfield_bar.dart';
// import 'package:moyeolam/friends/provider/friends_list_provider.dart';
import 'package:moyeolam/friends/model/friends_list_model.dart';
import 'package:moyeolam/friends/view_model/friend_search_view_model.dart';
import 'package:moyeolam/user/model/user_search_model.dart';

class AddFriendAlarmGroupView extends ConsumerStatefulWidget{
  final List<AddMemberModel?> invitedMember;
  final int alarmGroupId;
  const AddFriendAlarmGroupView({
    super.key,
    required this.invitedMember,
    required this.alarmGroupId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddFriendAlarmGroupViewState(
    alarmGroupId: alarmGroupId,
    invitedMember: invitedMember,
  );

}

class _AddFriendAlarmGroupViewState extends ConsumerState {
  late final AddFriendAlarmGroupViewModel _addFriendAlarmGroupViewModel;

  final TextEditingController _searchFriend = TextEditingController();
  final FocusNode textFocus = FocusNode();
  final List<AddMemberModel?> invitedMember;
  final int alarmGroupId;

  _AddFriendAlarmGroupViewState({
    required this.invitedMember,
    required this.alarmGroupId,
  });

  @override
  void dispose() {
    // TODO: implement dispose
    textFocus.dispose();
    _searchFriend.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _addFriendAlarmGroupViewModel = AddFriendAlarmGroupViewModel();
    if (invitedMember.isNotEmpty) {
      _addFriendAlarmGroupViewModel.clearMember();
      for (int index = 1; index < invitedMember.length; index++) {
        _addFriendAlarmGroupViewModel.setMember(
            invitedMember[index]!.memberId, invitedMember[index]!.nickname);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // var addFriend = ref.watch(addFriendAlarmProvider.notifier);
    var searchFriend = ref.watch(friendSearchNotifierProvider.notifier);

    List<AddMemberModel?> members = _addFriendAlarmGroupViewModel.members;
    AsyncValue<List<FriendModel?>?> searchedFriends = ref.watch(
        friendSearchProvider);

    return Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        appBar: TitleBar(
          appBar: AppBar(),
          title: "친구 초대",
          leading: BtnBack(
              onPressed: () {
                Navigator.of(context).pop();
              }
          ),
          actions: [
            BtnSaveUpdate(
              onPressed: () async {
                _addFriendAlarmGroupViewModel.inviteFriend(
                    alarmGroupId, _addFriendAlarmGroupViewModel.checkId);
                Navigator.of(context).pop();
              },
              text: "초대",
            ),
          ],
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: (){
              textFocus.unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    // color: Colors.cyan,
                    height: 80,
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextFieldbox(
                      textFocus: textFocus,
                      setContents: (String _){},
                      controller: _searchFriend,
                      onSubmit: (String value) async {
                        searchFriend.setKeyword(value);
                        ref.invalidate(friendSearchProvider);
                        textFocus.unfocus();
                      },
                      suffixIconColor: FONT_COLOR,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search_outlined),
                        onPressed: (){
                          searchFriend.setKeyword(_searchFriend.text);
                          ref.invalidate(friendSearchProvider);
                          textFocus.unfocus();
                        },
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 80,
                      margin: EdgeInsets.only(left: 8, right: 8),
                      padding: EdgeInsets.only(left: 12, right: 12),
                      // color: Colors.deepOrange,
                      child: Row(
                        children: [
                          for (var member in members)
                            Container(
                              padding: const EdgeInsets.only(left: 4, right: 4),
                              child: ActionChip(
                                backgroundColor: MAIN_COLOR,
                                avatar: const Icon(Icons.remove),
                                label: Text("${member?.nickname}"),
                                onPressed: () async{
                                  await _addFriendAlarmGroupViewModel.deleteMember(
                                      member!);
                                  setState(() {
                                    members = _addFriendAlarmGroupViewModel.members;
                                  });
                                },
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 600,
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.only(left: 12, right: 12),
                    // color: Colors.yellowAccent,
                    child: searchedFriends.when(
                      data: (data) {
                        if (data != null) {

                          return
                            data.isEmpty?
                                const Center(
                                  child: Text("친구를 추가해보세요!",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 20,
                                    color: FONT_COLOR,
                                  ),
                                  ),
                                ):
                            ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              FriendModel? friend = data[index];
                              return ListTile(
                                onTap: ()async{
                                  await _addFriendAlarmGroupViewModel.setMember(friend.memberId, friend.nickname);
                                  setState(() {
                                    members = _addFriendAlarmGroupViewModel.members;
                                  });
                                },
                                title: Text("${friend!.nickname}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: FONT_COLOR,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.cyan,
                                ),
                                trailing: IconButton(
                                  onPressed: () async{
                                    await _addFriendAlarmGroupViewModel.setMember(friend.memberId, friend.nickname);
                                    setState(() {
                                      members = _addFriendAlarmGroupViewModel.members;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: FONT_COLOR,
                                  ),
                                  iconSize: 20,
                                ),
                              );
                            },
                          );
                        } else {
                          return Text("null data");
                        }
                      },
                      error: (error, stackTrace) {
                        print("Error: $error 123");
                        return const SpinKitFadingCube(
                          // FadingCube 모양 사용
                          color: Colors.blue, // 색상 설정
                          size: 50.0, // 크기 설정
                          duration: Duration(seconds: 2), //속도 설정
                        );
                      },
                      loading: () {
                        return const SpinKitFadingCube(
                          // FadingCube 모양 사용
                          color: Colors.blue, // 색상 설정
                          size: 50.0, // 크기 설정
                          duration: Duration(seconds: 2), //속도 설정
                        );
                      }
                  ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}


//Column(
//               children: [
//                 Container(
//                   height: 100,
//                   width: double.infinity,
//                   // child: Text("텍스트 필드창"),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: TextFieldbox(
//                       controller: _searchFriend,
//                       // setContents: AddFriendAlarmGroupViewModel().setFriendNickname,
//                       setContents: (String value) {
//                         // _searchFriend.text = value;
//                         // addFriend.setFriendNickname(_searchFriend.text);
//                       },
//                       onSubmit: (String value) {
//                         addFriend.setFriendNickname(value);
//                         ref.invalidate(friendSearchProvider);
//                       },
//                       suffixIcon: Icon(Icons.search),
//                       suffixIconColor: FONT_COLOR,
//                     ),
//                   ),
//                 ),
//
//                 Container(
//                   height: 60,
//                   width: double.infinity,
//                   // child: Text("초대할 친구 목록 창"),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: [
//                         for (var member in members)
//                           Container(
//                             padding: const EdgeInsets.only(left: 4, right: 4),
//                             child: ActionChip(
//                               backgroundColor: MAIN_COLOR,
//                               avatar: const Icon(Icons.remove),
//                               label: Text("${member?.nickname}"),
//                               onPressed: () {
//                                 ref.read(addFriendAlarmProvider).deleteMember(
//                                     member!);
//                               },
//                             ),
//                           )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(left: 32, right: 32, top: 32),
//                   width: double.infinity,
//
//                   // child: Text("친구 목록"),
//                   child: searchedFriends.when(
//                       data: (data) {
//                         if (data != null) {
//                           return ListView.builder(
//                               itemCount: data.length,
//                               itemBuilder: (context, index) {
//                                 FriendModel? friend = data[index];
//                                 return ListTile(
//                                   title: Text("${friend!.nickname}",
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       color: FONT_COLOR,
//                                       fontWeight: FontWeight.w200,
//                                     ),
//                                   ),
//                                   leading: const CircleAvatar(
//                                     backgroundColor: Colors.cyan,
//                                   ),
//                                   trailing: IconButton(
//                                     onPressed: () async{
//                                       addFriend.setMember(friend.memberId, friend.nickname);
//                                     },
//                                     icon: const Icon(
//                                       Icons.add,
//                                       color: FONT_COLOR,
//                                     ),
//                                     iconSize: 20,
//                                   ),
//                                 );
//                               },
//                           );
//                         } else {
//                           return Text("null data");
//                         }
//                       },
//                       error: (error, stackTrace) {
//                         print("Error: $error 123");
//                         return const SpinKitFadingCube(
//                           // FadingCube 모양 사용
//                           color: Colors.blue, // 색상 설정
//                           size: 50.0, // 크기 설정
//                           duration: Duration(seconds: 2), //속도 설정
//                         );
//                       },
//                       loading: () {
//                         return const SpinKitFadingCube(
//                           // FadingCube 모양 사용
//                           color: Colors.blue, // 색상 설정
//                           size: 50.0, // 크기 설정
//                           duration: Duration(seconds: 2), //속도 설정
//                         );
//                       }
//                   ),
//                 ),
//               ]
//           ),


//return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       // for (var friend in friends)
//                       // for(int index=0;i
//                       // if (data)
//                       for (FriendModel? friend in data)
//                         ListTile(
//                           onTap: () {
//                             print("${friend.memberId} invite view");
//                             ref
//                                 .read(addFriendAlarmProvider)
//                                 .setMember(friend.memberId, friend.nickname);
//                           },
//                           title: Text(friend!.nickname),
//                           contentPadding: EdgeInsets.only(top: 12),
//                           leading: Icon(Icons.add, color: FONT_COLOR),
//                           titleTextStyle: TextStyle(
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