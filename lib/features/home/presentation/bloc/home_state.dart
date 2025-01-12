import 'package:chatapp/features/home/domain/entity/home_entity.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadDataState extends HomeState {
  final List<HomeEntity> entity;
  HomeLoadDataState(this.entity);
  @override
  List<Object?> get props => [entity];
}

class HomeErrorState extends HomeState {
  final String msg;
  HomeErrorState(this.msg);
  @override
  List<Object?> get props => [msg];
}
