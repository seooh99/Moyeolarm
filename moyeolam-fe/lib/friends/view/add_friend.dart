import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youngjun/common/const/colors.dart';
import 'package:youngjun/common/textfield_bar.dart';

import '../component/friends_search_list.dart';
import '../model/friends_search_model.dart';
import '../repository/friends_repository.dart';

class AddFriends extends ConsumerStatefulWidget {
  const AddFriends({super.key});

  @override
  ConsumerState<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends ConsumerState<AddFriends> {
  final TextEditingController _searchController = TextEditingController();

  List<Friend>? _searchResults; // 검색 결과를 저장할 변수

  Future<void> _performSearch() async {
    final dio = Dio();
    final friendRepository = FriendsRepository(dio);

    final keyword = _searchController.text ?? '';
    final searchResult = await friendRepository.searchFriends(keyword);

    final filteredFriends = searchResult.data.friends
        .where((friend) =>
            friend.nickname.toLowerCase().contains(keyword.toLowerCase()))
        .toList();

    print('왱 ㅏㄴ됨');
    setState(() {
      _searchResults = filteredFriends.isEmpty ? null : filteredFriends;
      print('@@@@@@@@@@@@@@@');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _sendFriendRequest(String memberId) async {
    final dio = Dio();
    final friendRepository = FriendsRepository(dio);

    try {
      await friendRepository.friendRequestPost(memberId as Friend);
      print('Friend request sent successfully');
      // 요청을 보내고 나서 원하는 동작을 수행할 수 있습니다.
    } catch (e) {
      print('Error sending friend request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Dio dio = Dio();
    final friendRequest = FriendsRepository(dio);

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
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
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFieldbox(
              controller: _searchController,
              setContents: (String) {},
              suffixIcon: IconButton(
                  onPressed: () async {
                    await _performSearch();
                    print('IconButton Clicked');
                    _performSearch();
                  },
                  icon: Icon(
                    Icons.search_outlined,
                  )),
              suffixIconColor: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: MAIN_COLOR,
            thickness: 2,
          ),
          // FriendsSearchList(),
          _buildSearchResults(),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults == null) {
      return Container();
    }

    if (_searchResults!.isEmpty) {
      return Center(
        child: Text(
          'No results found',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: _searchResults!.length,
        itemBuilder: (context, index) {
          final friend = _searchResults![index];
          return
              //   ListTile(
              //   title: Text(friend.nickname ?? ''),
              //   subtitle: Text(friend.memberId?.toString() ?? ''),
              //   leading: CircleAvatar(
              //     backgroundImage: NetworkImage(friend.profileImageUrl ?? ''),
              //   ),
              //
              // );
              ListTile(
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
                _sendFriendRequest(friend.memberId.toString());
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
}
