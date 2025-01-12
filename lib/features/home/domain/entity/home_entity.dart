class HomeEntity {
  final String id;
  final List<ParticipantEntity> participants;
  final List<MessageEntity> messages;
  final DateTime createdAt;
  final DateTime updatedAt;

  HomeEntity({
    required this.id,
    required this.participants,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
  });
}

class MessageEntity {
  final String? id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MessageEntity({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });
}

class ParticipantEntity {
  final String id;
  final String username;
  final String profilepic;

  ParticipantEntity({
    required this.id,
    required this.username,
    required this.profilepic,
  });
}
