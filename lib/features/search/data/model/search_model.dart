import 'package:chatapp/features/search/domain/entity/search_entity.dart';

import 'package:json_annotation/json_annotation.dart';


part 'search_model.g.dart';

@JsonSerializable()
class SearchModel extends SearchEntity {
  @JsonKey(name: "_id")
  final String id;
  @JsonKey(name: "username")
  final String username;
  @JsonKey(name: "password")
  final String password;
  @JsonKey(name: "gender")
  final String gender;
  @JsonKey(name: "profilepic")
  final String profilepic;
  @JsonKey(name: "__v")
  final int v;

  SearchModel({
    required this.id,
    required this.username,
    required this.password,
    required this.gender,
    required this.profilepic,
    required this.v,
  }) : super(
            id: id,
            username: username,
            password: password,
            gender: gender,
            profilepic: profilepic,
            v: v);

  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchModelToJson(this);
}
