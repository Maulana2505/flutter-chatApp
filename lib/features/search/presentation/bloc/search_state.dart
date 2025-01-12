import 'package:chatapp/features/search/domain/entity/search_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadState extends SearchState {
  final List<SearchEntity> search;
  SearchLoadState(this.search);
  @override
  
  List<Object?> get props => [search];
}

class SearchErrorState extends SearchState {
  final String msg;
  SearchErrorState(this.msg);
  @override
  List<Object?> get props => [msg];
}
