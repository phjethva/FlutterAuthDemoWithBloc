import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class UserLogin extends AuthEvent {
  final String email;
  final String password;

  UserLogin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class UserSignup extends AuthEvent {
  final String fname;
  final String lname;
  final String email;
  final String password;
  final String cnfpassword;

  UserSignup({required this.fname, required this.lname, required this.email, required this.password, required this.cnfpassword});

  @override
  List<Object> get props => [email, password];
}

class UserLogout extends AuthEvent {}
