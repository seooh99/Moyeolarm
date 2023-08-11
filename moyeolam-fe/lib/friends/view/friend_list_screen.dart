import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/layout/title_bar.dart';
import 'package:youngjun/friends/provider/friends_search_provider.dart';
import 'package:youngjun/friends/repository/friends_repository.dart';

import '../../common/layout/main_nav.dart';
import '../../common/textfield_bar.dart';
import '../component/friends_list.dart';
import '../model/friends_list_model.dart';

import '../provider/friends_delete_provider.dart';
import '../provider/friends_list_provider.dart';
import 'add_friend.dart';

class FriendListScreen extends ConsumerStatefulWidget {

  FriendListScreen({super.key});

  @override
  ConsumerState<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends ConsumerState<FriendListScreen> {
  List<FriendsListModel> friendsList = <FriendsListModel>[];

  final ScrollController controller = ScrollController();

  final FriendsDeleteNotifier _friendsDeleteNotifier = FriendsDeleteNotifier();

  void moveScroll() {
    controller.animateTo(controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 700), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<Friend>?> friends = ref.watch(friendsListProvider);

    return Scaffold(
      appBar: TitleBar(
        appBar: AppBar(),
        title: '모여람',
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddFriends(),
                ),
              );
            },
            icon: Icon(
              Icons.person_add,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: BACKGROUND_COLOR,
      body: Column(
        children: [
          Column(
            children: [
              TextFieldbox(
                setContents: (String) {},
                suffixIcon: Icon(Icons.search),
                suffixIconColor: Colors.white,
                colors: null,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 320,
                height: 160,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: BorderSide(
                      width: 3,
                      color: SUB_COLOR,
                    ),
                  ),
                  color: BACKGROUND_COLOR,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.deepOrange,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      SizedBox(
                        height: 90,
                        width: 120,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '닉네임',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.drive_file_rename_outline,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '활성 알람 : 2개',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Column(
              children: [
                friends.when(
                  data: (data) {
                    if (data != null) {
                      return Expanded(
                        child: CustomScrollView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          slivers: [
                            SliverList.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                Friend friend = data[index];
                                return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.lightBlue,
                                    ),
                                    title: Text(
                                      friend.nickname,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        _showDeleteConfirmationDialog(
                                            context, friend);
                                      },
                                      icon: Icon(Icons.close),
                                    ));
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    ;
                    return Text('데이터없음');
                  },
                  error: (e, stackTrace) {
                    return Text('에러');
                  },
                  loading: () {
                    return Text('로딩중');
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, Friend friend) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('친구 삭제'),
          content: Text('${friend.nickname} 친구를 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () async {

                Navigator.pop(context);
                await _friendsDeleteNotifier.removeFriend(friend);
                ref.refresh(friendsListProvider); // 수정된 부분
              },
              child: Text('삭제'),
            ),
          ],
        );
      },
    );
  }
}

// CustomScrollView(
// scrollDirection: Axis.vertical,
// controller: controller,
// slivers: [
// SliverList(
// delegate: SliverChildBuilderDelegate(
// (context, index) {
// return
