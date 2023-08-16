import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/common/button/btn_back.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/layout/title_bar.dart';
import 'package:youngjun/common/textfield_bar.dart';
import 'package:youngjun/friends/view_model/friend_add_view_model.dart';
import 'package:youngjun/user/model/user_search_model.dart';

class MakeFriendView extends ConsumerStatefulWidget {
  const MakeFriendView({super.key});

  @override
  ConsumerState<MakeFriendView> createState() => _MakeFriendViewState();
}

class _MakeFriendViewState extends ConsumerState<MakeFriendView> {
  final TextEditingController _searchFriend = TextEditingController();
  final FriendAddViewModel _friendAddViewModel = FriendAddViewModel();
  @override
  void dispose() {
    // TODO: implement dispose
    _searchFriend.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    AsyncValue<MemberModel?> foundMember = ref.watch(memberSearchProvider);
    var settingSearch = ref.watch(memberSearchSettingProvider.notifier);
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: TitleBar(
          appBar: AppBar(),
          title: "친구 추가",
        leading: BtnBack(
          onPressed: (){
            Navigator.of(context).pop();
          }
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              height: 80,
              child: TextFieldbox(
                hint: "검색할 친구를 입력하세요",
                setContents: (String value){
                  settingSearch.setKeyword(value);
                  friendAddViewModel.searchMember();
                },
                controller: _searchFriend,
                onSubmit: (String value ){
                  settingSearch.setKeyword(value);
                  // await friendAddViewModel.searchMember();
                  ref.invalidate(memberSearchProvider);
                },
                suffixIcon: const Icon(Icons.search_outlined),
                suffixIconColor: FONT_COLOR,
              ),
            ),
            foundMember.when(
                  data: (data){
                    // print("make friend view: data: ${data}");
                    if(data != null) {
                    return Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(8.0),
                    height: 80,
                    child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.amber,
                            ),
                            Text("${data.nickname}",
                            style: TextStyle(
                              color: FONT_COLOR,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                                onPressed:
                                    data.isFriend?(){
                                      final snack1 =  SnackBar(
                                        content: Text("이미 친구인 사용자 입니다.",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: FONT_COLOR
                                          ),
                                        ),
                                        duration: Duration(seconds: 1),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snack1);
                                }:
                                () async {
                                  var response = await _friendAddViewModel.makeFriend(data.memberId);
                                  if (!response){
                                    final snack2 =  SnackBar(
                                     content: Text("이미 처리 중인 요청입니다.",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: FONT_COLOR
                                      ),
                                     ),
                                      duration: Duration(seconds: 1),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snack2);
                                  }
                                },
                                icon: Icon(
                                  Icons.person_add_alt_1,
                                  color: FONT_COLOR,
                                  size: 32,
                                )
                            )

                          ],
                        ),
                    ),
                    );
                  }
                    else{
                      print("data!!");

                      return Container(
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(8.0),
                          height: 680,
                          child: Text(""),
                          );
                      }
                },
                  error: (error, stackTrace){
                    return Text("Error: $error");
                  },
                  loading: (){
                    return Text("loading");
                  },
              ),

          ],
        ),
      ),
    );
  }


}

