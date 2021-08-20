import 'package:equatable/equatable.dart';

abstract class SignupValidationEvent extends Equatable {
  SignupValidationEvent();

  @override
  List<Object> get props => [];
}

class FnameChanged extends SignupValidationEvent {
  FnameChanged({required this.fname});

  final String fname;

  @override
  List<Object> get props => [fname];
}

class FnameUnfocused extends SignupValidationEvent {}

class LnameChanged extends SignupValidationEvent {
  LnameChanged({required this.lname});

  final String lname;

  @override
  List<Object> get props => [lname];
}

class LnameUnfocused extends SignupValidationEvent {}

class EmailChanged extends SignupValidationEvent {
  EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailUnfocused extends SignupValidationEvent {}

class PasswordChanged extends SignupValidationEvent {
  PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordUnfocused extends SignupValidationEvent {}

class CnfPasswordChanged extends SignupValidationEvent {
  CnfPasswordChanged({required this.cnfpassword});

  final String cnfpassword;

  @override
  List<Object> get props => [cnfpassword];
}

class CnfPasswordUnfocused extends SignupValidationEvent {}

class SignupFormSubmitted extends SignupValidationEvent {}
