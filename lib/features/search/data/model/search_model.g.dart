// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) => SearchModel(
      id: json['_id'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      gender: json['gender'] as String,
      profilepic: json['profilepic'] as String,
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'gender': instance.gender,
      'profilepic': instance.profilepic,
      '__v': instance.v,
    };
