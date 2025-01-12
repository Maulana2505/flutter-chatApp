
import 'package:chatapp/features/home/domain/entity/home_entity.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeLoadDataEvent extends HomeEvent {}


class HomeRecieverEvent extends HomeEvent{
  final MessageEntity message;
  HomeRecieverEvent(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
