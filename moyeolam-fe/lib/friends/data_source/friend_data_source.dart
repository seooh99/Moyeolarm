import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:youngjun/friends/model/friend_delete_model.dart';
import 'package:youngjun/friends/model/friends_add_model.dart';
import 'package:youngjun/friends/model/friends_list_model.dart';
import 'package:youngjun/friends/model/friends_search_model.dart';


part 'friend_data_source.g.dart';

@RestApi()
abstract class FriendDataSource {
  factory FriendDataSource(Dio dio, {String baseUrl}) =
  _FriendDataSource;
  // 친구 전체 조회
  @GET('/friends')
  Future<FriendsListResponseModel> getFriendsList(
      @Header('Authorization') String token,
    );
  // 친구 요청
  @POST('/friends/{memberId}/request')
  Future<FriendsAddResponseModel> friendRequestPost(
      @Header('Authorization') String token,
      @Path("memberId") int memberId,
      );
  // 친구 검색
  @GET('/friends/search')
  Future<FriendsSearchResponseModel> searchFriends(
      @Header('Authorization') String token,
      @Query('keyword') String keyword,
      );
  // 친구 삭제
  @DELETE('/friends/{myFriendId}')
  Future<FriendsDeleteResponseModel> deleteFriend(
      @Header('Authorization') String token,
      @Path("myFriendId") int myFriendId,
      );

}

