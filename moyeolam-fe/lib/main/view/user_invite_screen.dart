import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/textfield_bar.dart';

class UserInviteScreen extends StatefulWidget {
  const UserInviteScreen({super.key});

  @override
  State<UserInviteScreen> createState() => _UserInviteScreenState();
}

class _UserInviteScreenState extends State<UserInviteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
            child: TextFieldbox(
              setContents: (String) {},
              suffixIcon: Icon(Icons.search),
              suffixIconColor: Colors.white,
            ),
          ),
          Divider(),
          SizedBox(
            height: 30,
          ),
          ListView(
            padding: EdgeInsets.all(8),
            children: [
              ListTile(
                title: Text('친구 111'),
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
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
            ],
          )
        ],
      ),
    );
  }
}
