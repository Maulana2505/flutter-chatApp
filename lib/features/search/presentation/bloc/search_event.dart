import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchLoadEvent extends SearchEvent {
  final String query;
  SearchLoadEvent(this.query);
  @override
  
  List<Object?> get props => [query];
}
