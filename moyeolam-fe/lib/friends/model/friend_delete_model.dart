
import 'package:json_annotation/json_annotation.dart';

part 'friend_delete_model.g.dart';

@JsonSerializable()
class FriendsDeleteResponseModel {
  final String code;
  final String message;


  FriendsDeleteResponseModel({
    required this.code,
    required this.message,
  });

  factory FriendsDeleteResponseModel.fromJson(Map<String, dynamic> json) => _$FriendsDeleteResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsDeleteResponseModelToJson(this);
}

