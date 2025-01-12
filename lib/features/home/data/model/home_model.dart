import 'package:chatapp/features/home/domain/entity/home_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeModel extends HomeEntity{
  @JsonKey(name: "_id")
  final String id;
  final List<Participant> participants;
  final List<Message> messages;
  final DateTime createdAt;
  final DateTime updatedAt;
  HomeModel({
    required this.id,
    required this.participants,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
  }) : super(id: id, participants: participants, messages: messages, createdAt: createdAt, updatedAt: updatedAt);

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}

@JsonSerializable()
class Message extends MessageEntity{
  @JsonKey(name: "_id")
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  }) : super(id: id, senderId: senderId, receiverId: receiverId, message: message, createdAt: createdAt, updatedAt: updatedAt);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class Participant extends ParticipantEntity{
  @JsonKey(name: "_id")
  final String id;
  final String username;
  final String profilepic;
  Participant({
    required this.id,
    required this.username,
    required this.profilepic,
  }) : super(id: id, username: username, profilepic: profilepic);

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantToJson(this);
}
