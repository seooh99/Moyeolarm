import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';

import '../repository/friends_repository.dart';

class FriendsSearchList extends StatefulWidget {
  const FriendsSearchList({super.key});

  @override
  State<FriendsSearchList> createState() => _FriendsSearchListState();
}

class _FriendsSearchListState extends State<FriendsSearchList> {
  @override
  Widget build(BuildContext context) {
    Dio dio = Dio();
    final friendRequest = FriendsRepository(dio);

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
            trailing: ElevatedButton(
              onPressed: () {
                // friendRequest.friendRequestPost();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MAIN_COLOR,
              ),
              child: Text(
                '요청',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
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
            trailing: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: MAIN_COLOR,
              ),
              child: Text(
                '요청',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          // ListTile(
          //   leading: CircleAvatar(
          //     backgroundColor: Colors.deepPurpleAccent,
          //   ),
          //   title: Text(
          //     '친구 333',
          //     style: TextStyle(
          //       color: Colors.white,
          //     ),
          //   ),
          //   trailing: IconButton(
          //     onPressed: () {},
          //     icon: ElevatedButton(
          //       onPressed: () {},
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: MAIN_COLOR,
          //       ),
          //       child: Text('요청',
          //         style: TextStyle(
          //           color: Colors.white,
          //         ),),
          //     ),
          //   ),
          // ),

          Expanded(
            child: Column(
              children: [
              ],
            )
          ),
        ],
      ),
    );
  }
}
