// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => HomeModel(
      id: json['_id'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      '_id': instance.id,
      'participants': instance.participants.map((e) => e.toJson()).toList(),
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['_id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      message: json['message'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      '_id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'message': instance.message,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
      id: json['_id'] as String,
      username: json['username'] as String,
      profilepic: json['profilepic'] as String,
    );

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'profilepic': instance.profilepic,
    };
