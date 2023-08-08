import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/layout/title_bar.dart';
import 'package:youngjun/common/textfield_bar.dart';

import '../component/friends_search_list.dart';

class AddFriends extends StatefulWidget {
  const AddFriends({super.key});

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back,
        color: Colors.white,),
        backgroundColor: BACKGROUND_COLOR,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextFieldbox(
            setContents: (String) {},
            suffixIcon: Icon(Icons.search),
            suffixIconColor: Colors.white,
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: MAIN_COLOR,
            thickness: 2,
          ),
          FriendsSearchList(),
        ],
      ),
    );
  }
}
