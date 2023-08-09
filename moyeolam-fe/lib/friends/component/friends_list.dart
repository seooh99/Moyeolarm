import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/common/const/colors.dart';

import '../model/friends_list_model.dart';
import '../provider/friends_list_provider.dart';

class FriendsList extends ConsumerStatefulWidget {
  const FriendsList(
      {super.key});


  @override
  ConsumerState<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends ConsumerState<FriendsList> {

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<Friend>?> friends = ref.watch(friendsListProvider);

    return Column(
      children: [
        friends.when(
            data: (data){
              if(data != null){
                return CustomScrollView(
                  scrollDirection: Axis.vertical,
                  controller: controller,
                  slivers: [
                    SliverList(delegate: SliverChildBuilderDelegate((context, index){
                      return ListView.builder(
                        itemCount: data.length,
                        padding: EdgeInsets.all(8),
                        itemBuilder: (context, index){
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
                            trailing: Icon(Icons.close),
                          );
                        },
                      );
                    }))
                  ],
                );
              }
              return Scaffold();
            },
            error: (e,stackTrace){
              return Scaffold();
            },
            loading: (){
              return Scaffold();
            }
        ),
      ]
    );
  }
}
