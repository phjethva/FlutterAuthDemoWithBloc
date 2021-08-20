import 'package:equatable/equatable.dart';

abstract class LoginValidationEvent extends Equatable {
  LoginValidationEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginValidationEvent {
  EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailUnfocused extends LoginValidationEvent {}

class PasswordChanged extends LoginValidationEvent {
  PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordUnfocused extends LoginValidationEvent {}

class LoginFormSubmitted extends LoginValidationEvent {}
