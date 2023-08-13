import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/layout/title_bar.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:youngjun/friends/repository/friends_repository.dart';
import '../../common/textfield_bar.dart';
import '../../user/model/user_model.dart';
import '../model/friends_list_model.dart';
import '../provider/friends_delete_provider.dart';
import '../provider/friends_list_provider.dart';
import 'add_friend.dart';

class FriendListScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends ConsumerState<FriendListScreen> {
  List<FriendsListModel> friendsList = <FriendsListModel>[];

  // 스크롤 컨트롤러
  final ScrollController controller = ScrollController();

  // 친구 삭제 로직
  final FriendsDeleteNotifier _friendsDeleteNotifier = FriendsDeleteNotifier();

  // 검색바 컨트롤러
  final TextEditingController _searchController_list = TextEditingController();

  // 유저 정보
  UserInformation _userInformation = UserInformation();

  // 검색 결과 저장할 곳
  List<Friend>? _searchResults;


  // 스크롤러 메서드
  void moveScroll() {
    controller.animateTo(controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 700), curve: Curves.ease);
  }

  // 친구검색 로직
  Future<void> _friendsListSearch() async {
    final dio = Dio();
    final friendRepository = FriendsRepository(dio);

    final keyword = _searchController_list.text ?? '';

    print(keyword);

    if (keyword.isEmpty) {
      setState(() {
        _searchResults = null;
        print('키워드 비어있음');
      });
    } else {
      final searchResult = await friendRepository.searchFriends(keyword);
      print(keyword);
      final filteredFriends = searchResult.data.friends
          .where((friend) =>
              friend.nickname.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
      print(keyword);

      _updateSearchResults(filteredFriends.cast<Friend>());

    }
  }

  // 친구 검색 로직에 사용될 '키워드 저장'
  void _updateSearchResults(List<Friend> results) {
    setState(() {
      _searchResults = results.isNotEmpty ? results : null;
      print('키워드 저장');
      print(_searchResults.toString());
      print(_searchResults);
      print(_searchResults?.toList());
    });
  }

  // 컨트롤러 종료
  @override
  void dispose() {
    _searchController_list.dispose();
    super.dispose();
  }

  // UI 시작
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<Friend>?> friends = ref.watch(friendsListProvider);

    return Scaffold(
      // 앱바
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
      // 몸체 body
      body: Column(
        children: [
          Column(
            children: [
              TextFieldbox(
                controller: _searchController_list,
                setContents: (String value) {
                  // 검색어 입력이 발생할 때마다 검색어를 _searchController에 저장
                  _searchController_list.text = value;
                },
                suffixIcon: IconButton(
                  onPressed: () async {
                    await _friendsListSearch();
                    print('IconButton Clicked');
                  },
                  icon: Icon(
                    Icons.search_outlined,
                  ),
                ),
                suffixIconColor: Colors.white,
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
                      FutureBuilder<UserModel?>(
                        future: _userInformation.getUserInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return CircleAvatar(
                              backgroundColor: Colors.white,
                            );
                          } else if (snapshot.hasData) {
                            UserModel? userInfo = snapshot.data;
                            var profileImageUrl = userInfo?.profileImageUrl;
                            return CircleAvatar(
                              backgroundImage:
                                  NetworkImage(profileImageUrl ?? ''),
                            );
                          } else {
                            return CircleAvatar(
                              backgroundColor: Colors.white,
                            );
                          }
                        },
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      SizedBox(
                        height: 80,
                        width: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                FutureBuilder<UserModel?>(
                                  future: _userInformation.getUserInfo(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('오류 발생: ${snapshot.error}');
                                    } else if (snapshot.hasData) {
                                      UserModel? userInfo = snapshot.data;
                                      return Text(
                                        '${userInfo?.nickname ?? '닉네임 없음'}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        '닉네임 없음',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      );
                                    }
                                  },
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
          _buildSearchResults(),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  // 친구 삭제 시 뜨는 '모달창'
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
                await _friendsDeleteNotifier.removeFriend(friend);
                Navigator.pop(context);
                ref.refresh(friendsListProvider);
              },
              child: Text('삭제'),
            ),
          ],
        );
      },
    );
  }

  // 친구목록 UI 및 로직
  Widget _buildSearchResults() {
    AsyncValue<List<Friend>?> friends = ref.watch(friendsListProvider);
    if (_searchResults == null || _searchResults!.isEmpty) {
      print(_searchResults);
      return Expanded(
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
      );
    }
    print(_searchResults);
    return Expanded(
      child: ListView.builder(
        itemCount: _searchResults!.length,
        itemBuilder: (context, index) {
          final friend = _searchResults![index];
          return ListTile(
            leading: CircleAvatar(
                //backgroundImage: NetworkImage(friend.profileImageUrl ?? ''),
                ),
            title: Text(
              friend.nickname ?? '',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                _showDeleteConfirmationDialog(context, friend);
              },
              icon: Icon(Icons.close),
            ),
          );
        },
      ),
    );
  }
}
