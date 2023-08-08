import 'package:flutter/material.dart';
import 'package:youngjun/common/layout/title_bar.dart';

import '../../common/textfield_bar.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({super.key});

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(
        appBar: AppBar(),
        title: '모여람',
        actions: [
          Icon(Icons.add_reaction_outlined),
        ],
        leading: null,
      ),
      body: Column(
        children: [
          TextFieldbox(
            setContents: (String) {},
            suffixIcon: Icon(Icons.search),
            suffixIconColor: Colors.white,),
        ],
      ),
    );
  }
}
