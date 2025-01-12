import 'package:chatapp/features/chat/domain/entity/chat_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetchatState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetchatInitialState extends GetchatState {}

class GetchatLoadingState extends GetchatState {}

class GetchatLoadState extends GetchatState {
  final List<ChatEntity> chat;
  GetchatLoadState(this.chat);
  @override
  List<Object?> get props => [chat];
}

class GetchatErrorState extends GetchatState {
  final String msg;
  GetchatErrorState(this.msg);
  @override
  List<Object?> get props => [msg];
}


class SendMassageSucces extends GetchatState {}

class SendMassageError extends GetchatState {
  final String msg;
  SendMassageError(this.msg);
  @override
  // TODO: implement props
  List<Object?> get props => [msg];
}
