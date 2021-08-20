import 'package:equatable/equatable.dart';
import 'package:flutter_auth_demo_with_bloc/data/repository/validation_repository.dart';
import 'package:formz/formz.dart';

class LoginValidationState extends Equatable {
  LoginValidationState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final FormzStatus status;

  LoginValidationState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
  }) {
    return LoginValidationState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}
