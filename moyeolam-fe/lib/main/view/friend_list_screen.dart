import 'package:flutter/material.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/layout/title_bar.dart';

import '../../common/layout/main_nav.dart';
import '../../common/textfield_bar.dart';
import '../component/friends_list.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({super.key});

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: TitleBar(
        appBar: AppBar(),
        title: '모여람',
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_reaction_outlined),
            color: Colors.white,
          ),
        ],
        leading: null,
      ),
      body: Column(
        children: [
          TextFieldbox(
            setContents: (String) {},
            suffixIcon: Icon(Icons.search),
            suffixIconColor: Colors.white, colors: null,
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
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FriendsList(
            profileImage: null,
            nickname: null,
            deleteFriends: null,
          ),
        ],
      ),
      bottomSheet: MainNav(),
    );
  }
}
