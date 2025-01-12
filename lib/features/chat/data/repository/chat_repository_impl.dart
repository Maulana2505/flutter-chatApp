import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/core/utils/typedef.dart';
import 'package:chatapp/features/chat/data/datasource/remote/chat_remote_datasource.dart';
import 'package:chatapp/features/chat/domain/entity/chat_entity.dart';
import 'package:chatapp/features/chat/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatRemoteDatasource _chatRemoteDatasource;
  ChatRepositoryImpl(this._chatRemoteDatasource);
  @override
  ResultFuture<List<ChatEntity>> getChat(String id) async {
    try {
      final data = await _chatRemoteDatasource.getChat(id);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(massage: e.toString()));
    }
  }

  @override
  ResultVoid sendMessage( String receiverId, String message) async{
    try {
      final data = await _chatRemoteDatasource.sendChat(receiverId, message);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(massage: e.toString()));
    }
  }
}
