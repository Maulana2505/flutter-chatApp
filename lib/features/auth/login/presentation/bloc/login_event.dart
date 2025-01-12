import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSuccesEvent extends LoginEvent {
  final String username;
  final String password;
  LoginSuccesEvent(this.username, this.password);
  @override
  List<Object?> get props => [username, password];
}
