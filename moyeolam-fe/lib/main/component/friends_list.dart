import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';

class FriendsList extends StatefulWidget {
  const FriendsList(
      {required this.profileImage,
      required this.nickname,
      required this.deleteFriends,
      super.key});

  final Image? profileImage;
  final Text? nickname;
  final Widget? deleteFriends;

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepOrangeAccent,
            ),
            title: Text(
              '친구 111',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Icon(Icons.close),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.lightBlue,
            ),
            title: Text(
              '친구 222',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Icon(Icons.close),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurpleAccent,
            ),
            title: Text(
              '친구 333',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
