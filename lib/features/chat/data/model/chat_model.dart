import 'package:chatapp/features/chat/domain/entity/chat_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel extends ChatEntity {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  }) : super(
            id: id,
            senderId: senderId,
            receiverId: receiverId,
            message: message,
            createdAt: createdAt,
            updatedAt: updatedAt);

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
