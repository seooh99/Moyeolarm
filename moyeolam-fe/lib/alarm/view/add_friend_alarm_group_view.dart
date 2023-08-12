import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:youngjun/alarm/viewmodel/add_friend_alarm_group_view_model.dart';
import 'package:youngjun/common/button/btn_back.dart';
import 'package:youngjun/common/button/btn_save_update.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/layout/title_bar.dart';
import 'package:youngjun/common/textfield_bar.dart';
import 'package:youngjun/friends/model/friends_list_model.dart' as list_friends;
import 'package:youngjun/friends/model/friends_search_model.dart';
import 'package:youngjun/friends/provider/friends_list_provider.dart';

class AddFriendAlarmGroupView extends ConsumerStatefulWidget{
  final List<int?> invitedMember;
  final int alarmGroupId;
  const AddFriendAlarmGroupView({
    super.key,
    required this.invitedMember,
    required this.alarmGroupId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddFriendAlarmGroupViewState();

}

class _AddFriendAlarmGroupViewState extends ConsumerState{
  final AddFriendAlarmGroupViewModel _AddFriendAlarmGroupViewModel = AddFriendAlarmGroupViewModel();
  @override
  void initState() {
    // TODO: implement initState
    // for (int memberId in ) {
    //   ref.read(addFriendAlarmProvider).setMemberIds(memberId);
    // }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var addFriend = ref.watch(addFriendAlarmProvider);
    List<MemberModel?> members = addFriend.members;

    AsyncValue<FriendsSearchModel> searchedFriends = ref.watch(searchFriendProvider);
    AsyncValue<List<list_friends.Friend>?> friends = ref.watch(friendsListProvider);
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: TitleBar(
          appBar: AppBar(), 
          title: "친구 초대",
        leading: BtnBack(
          onPressed: (){
            Navigator.of(context).pop();
          }
        ),
        actions: [
          BtnSaveUpdate(
              onPressed: () async {
                await _AddFriendAlarmGroupViewModel.inviteFriend(1, addFriend.checkId);
                Navigator.of(context).pop();
              }, 
              text: "초대",
          ),
        ],
      ),
      body: Column(
        children: [
          Container(

            height: 100,
            width: double.infinity,
            // child: Text("텍스트 필드창"),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFieldbox(
                  setContents: AddFriendAlarmGroupViewModel().setFriendNickname,
                  suffixIcon: Icon(Icons.search),

              ),
            ),
          ),

          Container(
            height: 60,
            width: double.infinity,
            // child: Text("초대할 친구 목록 창"),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var member in members)
                    Container(
                      child: ActionChip(
                        backgroundColor: MAIN_COLOR,
                          avatar: Icon(Icons.remove),
                          label: Text("${member?.nickname}"),
                          onPressed: () {
                            ref.read(addFriendAlarmProvider).deleteMember(member!);
                          },
                    ),
                      padding: EdgeInsets.only(left: 4, right: 4),
                    )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 32, right: 32, top: 32),
            width: double.infinity,

            // child: Text("친구 목록"),
            child: friends.when(
                      data: (data){
                        // if(data.data == "200") {
                        //   var friends = data.data.friends;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // for (var friend in friends)
                      for (var friend in data!)
                        ListTile(
                          onTap: () {
                            print("${friend.memberId}");
                            ref
                                .read(addFriendAlarmProvider)
                                .setMember(friend.memberId, friend.nickname);
                          },
                          title: Text(friend!.nickname),
                          contentPadding: EdgeInsets.only(top: 12),
                          leading: Icon(Icons.add, color: FONT_COLOR),
                          titleTextStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          // selected: true,
                          // selectedTileColor: ,
                        ),
                    ],
                  ),
                  //    child: ListView.builder(
                  //      // padding: EdgeInsets.all(1),
                  //      itemCount: data?.length,
                  //        itemBuilder: (context, index) {
                  //            return ListTile(
                  //              onTap: (){},
                  //              selected: true,
                  //
                  //              selectedColor: Colors.grey,
                  //              // title: Text(data![index].nickname),
                  //              title: Text("test"),
                  //            );
                  //        },
                  //    )
                );
              // }
            },
                      error: (error, stackTrace){
                        return const SpinKitFadingCube(
                        // FadingCube 모양 사용
                        color: Colors.blue, // 색상 설정
                        size: 50.0, // 크기 설정
                        duration: Duration(seconds: 2), //속도 설정
                        );
                      },
                      loading: (){
                        return const SpinKitFadingCube(
                          // FadingCube 모양 사용
                          color: Colors.blue, // 색상 설정
                          size: 50.0, // 크기 설정
                          duration: Duration(seconds: 2), //속도 설정
                        );
                      }
                  ),
                ),
            ]
      )
    );
  }

}
