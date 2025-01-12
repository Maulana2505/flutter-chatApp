import 'package:chatapp/features/chat/domain/entity/chat_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetchatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetchatLoadEvent extends GetchatEvent {
  final String id;
  GetchatLoadEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class SendMassageEvent extends GetchatEvent {
  
  final String recieverId;
  final String message;
  SendMassageEvent( this.recieverId, this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [ recieverId, message];
}

class MassageRecieverEvent extends GetchatEvent {
  final ChatEntity message;

  MassageRecieverEvent(this.message);

  @override
  List<Object> get props => [message];
}
