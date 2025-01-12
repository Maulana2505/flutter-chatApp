import 'package:chatapp/core/utils/typedef.dart';
import 'package:chatapp/features/chat/domain/entity/chat_entity.dart';
import 'package:chatapp/features/chat/domain/repository/chat_repository.dart';

class GetChatUsecase {
  final ChatRepository _chatRepository;
  GetChatUsecase(this._chatRepository);
  ResultFuture<List<ChatEntity>> call(String id) async {
    return await _chatRepository.getChat(id);
  }
}

class SendChatUsecase {
  final ChatRepository _chatRepository;
  SendChatUsecase(this._chatRepository);
  ResultVoid call(String receiverId, String message) async {
    return await _chatRepository.sendMessage(receiverId, message);
  }
}
