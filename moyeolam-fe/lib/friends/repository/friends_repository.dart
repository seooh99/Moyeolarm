

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../common/const/address_config.dart';
import '../model/friends_search_model.dart';

part 'friends_repository.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class FriendsRepository {
  factory FriendsRepository(Dio dio, {String baseUrl}) =
  _FriendsRepository;

  @POST('/friends/{memberId}/request')
  Future<Friend> friendRequestPost(@Path() Friend memberId,

      );
  @GET('/friends/search')
  Future<FriendsSearchModel> searchFriends(@Query('keyword') String keyword);

  @DELETE('/friends/{myFriendId}')
  Future<void> deleteFriend(@Path() int myFriendId);

}

