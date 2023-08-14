import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/common/const/address_config.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/secure_storage/secure_storage.dart';
import 'package:youngjun/common/textfield_bar.dart';
import 'package:youngjun/main.dart';
import 'package:youngjun/user/model/user_model.dart';

import '../component/friends_search_list.dart';
import '../model/friends_list_model.dart';
import '../repository/friends_repository.dart';

class AddFriends extends ConsumerStatefulWidget {
  const AddFriends({super.key});

  @override
  ConsumerState<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends ConsumerState<AddFriends> {
  UserInformation _userInformation = UserInformation(storage);
  final TextEditingController _searchController = TextEditingController();
  List<Friend>? _searchResults;

  // 검색바 컨트롤러
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // 검색 메서드
  Future<void> _performSearch() async {
    final keyword = _searchController.text.trim();

    if (keyword.isEmpty) {
      setState(() {
        _searchResults = null;
      });
      return;
    }

    final dio = Dio(BaseOptions(baseUrl: BASE_URL));
    final friendRepository = FriendsRepository(dio);
    UserModel? userInfo = await _userInformation.getUserInfo();
    String token = "Bearer ${userInfo!.accessToken}";
    final searchResult = await friendRepository.searchFriends(token, keyword);
    final filteredFriends = searchResult.data.friends.where(
            (friend) => friend.nickname.toLowerCase().contains(keyword.toLowerCase())
    ).toList();

    setState(() {
      _searchResults = filteredFriends.isEmpty ? null : filteredFriends;
    });
  }

  // 검색 후 나온 친구한테 '친구 요청' 메서드ㄴㄴ
  Future<void> _sendFriendRequest(int memberId) async {
    final dio = Dio(BaseOptions(baseUrl: BASE_URL));
    final friendRepository = FriendsRepository(dio);
    UserModel? userInfo = await _userInformation.getUserInfo();
    String token = "Bearer ${userInfo!.accessToken}";
    try {
      await friendRepository.friendRequestPost(token ,memberId);
      print('Friend request sent successfully');
    } catch (e) {
      print('Error sending friend request: $e');
    }
  }

  // 검색 결과 로직 위젯
  Widget _buildSearchResults() {
    if (_searchResults == null) {
      return Container();
    }

    if (_searchResults!.isEmpty) {
      return Center(
        child: Text(
          '검색 결과가 없습니다',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: _searchResults!.length,
        itemBuilder: (context, index) {
          final friend = _searchResults![index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(friend.profileImageUrl ?? ''),
            ),
            title: Text(
              friend.nickname ?? '',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MAIN_COLOR,
              ),
              onPressed: () {
                _sendFriendRequest(friend.memberId);
              },
              child: Text(
                '요청',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // 실제 페이지
  @override
  Widget build(BuildContext context) {
    final dio = Dio(BaseOptions(baseUrl: BASE_URL));
    final friendRequest = FriendsRepository(dio);

    return Scaffold(
      // 배경색
      backgroundColor: BACKGROUND_COLOR,
      // 앱바
      appBar: AppBar(
        backgroundColor: BACKGROUND_COLOR,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      // 몸체 body
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFieldbox(
              controller: _searchController,
              setContents: (String value) {
                _searchController.text = value;
              },
              suffixIcon: IconButton(
                onPressed: _performSearch,
                icon: Icon(
                  Icons.search_outlined,
                ),
              ),
              suffixIconColor: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Divider(
            color: MAIN_COLOR,
            thickness: 2,
          ),
          _buildSearchResults(),
        ],
      ),
    );
  }
}