class ChatEntity {
    final String id;
    final String senderId;
    final String receiverId;
    final String message;
    final DateTime createdAt;
    final DateTime updatedAt;

    ChatEntity({
        required this.id,
        required this.senderId,
        required this.receiverId,
        required this.message,
        required this.createdAt,
        required this.updatedAt,
    });

}
