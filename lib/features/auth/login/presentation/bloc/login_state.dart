// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccesState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(
    this.error,
  );
  @override
  List<Object?> get props => [error];
}
