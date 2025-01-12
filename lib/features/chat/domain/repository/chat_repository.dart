

import 'package:chatapp/core/utils/typedef.dart';
import 'package:chatapp/features/chat/domain/entity/chat_entity.dart';

abstract class ChatRepository {
  ResultFuture<List<ChatEntity>> getChat(String id);
  ResultVoid sendMessage(String receiverId,String message);
}