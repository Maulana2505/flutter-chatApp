// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupDataEvent extends SignupEvent {
  final String username;
  final String password;
  final String confirmPassword;
  final String gender;
  SignupDataEvent({
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.gender,
  });
  @override
  List<Object?> get props => [username, password, confirmPassword, gender];
}
