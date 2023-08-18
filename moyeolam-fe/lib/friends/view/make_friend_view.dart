import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moyeolam/common/button/btn_back.dart';
import 'package:moyeolam/common/const/colors.dart';
import 'package:moyeolam/common/layout/title_bar.dart';
import 'package:moyeolam/common/textfield_bar.dart';
import 'package:moyeolam/friends/view_model/friend_add_view_model.dart';
import 'package:moyeolam/user/model/user_search_model.dart';

class MakeFriendView extends ConsumerStatefulWidget {
  const MakeFriendView({super.key});

  @override
  ConsumerState<MakeFriendView> createState() => _MakeFriendViewState();
}

class _MakeFriendViewState extends ConsumerState<MakeFriendView> {
  final TextEditingController _searchFriend = TextEditingController();
  final FriendAddViewModel _friendAddViewModel = FriendAddViewModel();
  final FocusNode textFocus = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _searchFriend.dispose();
    textFocus.dispose();
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
      body: GestureDetector(
        onTap: (){
          textFocus.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(8.0),
                height: 80,
                child: TextFieldbox(
                  textFocus: textFocus,
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
                    textFocus.unfocus();
                  },
                  suffixIcon: IconButton(
                    onPressed: (){
                      settingSearch.setKeyword(_searchFriend.text);
                      ref.invalidate(memberSearchProvider);
                      textFocus.unfocus();
                    },
                    icon: Icon(Icons.search_outlined),
                  ),
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
                              SizedBox(
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: (data.profileImageUrl != null)?Image.network("${data.profileImageUrl}"):Icon(Icons.person,size:30,color: SUB_COLOR,),
                                ),
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
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).size.height - 100,
                                            left: 10,
                                            right: 10,
                                          ),
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
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).size.height - 100,
                                          left: 10,
                                          right: 10,
                                        ),
                                       content: Text("이미 처리 중인 요청입니다.",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: FONT_COLOR
                                        ),
                                       ),
                                        duration: Duration(seconds: 1),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snack2);
                                    }else{
                                      final snack3 =  SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).size.height - 100,
                                          left: 10,
                                          right: 10,
                                        ),
                                        content: Text("친구요청을 보냈습니다.",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: FONT_COLOR
                                          ),
                                        ),
                                        duration: Duration(seconds: 1),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snack3);
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
      ),
    );
  }


}

