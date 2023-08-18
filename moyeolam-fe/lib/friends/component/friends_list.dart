import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moyeolam/common/confirm.dart';
import 'package:moyeolam/common/const/colors.dart';
import 'package:moyeolam/friends/model/friends_list_model.dart';
import 'package:moyeolam/friends/view_model/friend_add_view_model.dart';
import 'package:moyeolam/friends/view_model/friend_list_view_model.dart';
import 'package:moyeolam/friends/view_model/friend_search_view_model.dart';

List<Color> colorList = [Colors.lightBlue, Colors.red];

class FriendsList extends ConsumerStatefulWidget {
  const FriendsList({
    super.key,
    required this.friends,
    required this.isFriend,
  });
  final bool isFriend;
  final List<FriendModel?> friends;
  @override
  ConsumerState<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends ConsumerState<FriendsList> {
  final FriendListViewModel _friendListViewModel = FriendListViewModel();
  final FriendAddViewModel _friendAddViewModel = FriendAddViewModel();
  bool requested = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.friends.length,
        itemBuilder: (context, index) {
          FriendModel? friend = widget.friends[index];
          // print("friend: ${friend!.nickname}");
          return ListTile(
            title: Text("${friend!.nickname}",
            style: TextStyle(
              fontSize: 20,
              color: FONT_COLOR,
              fontWeight: FontWeight.w200,
            )),

            leading: const CircleAvatar(
              // backgroundColor: colorList[index % 3],
              backgroundColor: Colors.blue,
            ),
          trailing: widget.isFriend?
          IconButton(
            onPressed: () async{
              showDialog(
                context: context,
                builder: (context) {
                  return ConfirmDialog(
                    title: "친구 삭제",
                    content: "${friend.nickname}님 을/를 친구 목록에서 삭제하시겠습니까?",
                    okTitle: "삭제",
                    okOnPressed: () async {
                      _friendListViewModel.deleteFriend(friend.memberId);
                      ref.invalidate(friendListProvider);
                      Navigator.of(context).pop();
                    },
                    cancelTitle: "취소",
                    cancelOnPressed: (){
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
            },
            icon: const Icon(
              Icons.close,
              color: FONT_COLOR,
            ),
          ): requested?
              Icon(Icons.person_add_alt_1,
              color: CKECK_GRAY_COLOR,):

          IconButton(
            onPressed: () async{
              bool isOk = await _friendAddViewModel.makeFriend(friend.memberId);
              setState(() {
                requested = isOk;
              });
              // Timer(Duration., () { })
            },
            icon: const Icon(
              Icons.person_add_alt_1,
              color: FONT_COLOR,
            ),
          ),
          );
        }
    );
  }
}
