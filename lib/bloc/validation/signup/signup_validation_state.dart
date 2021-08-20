import 'package:equatable/equatable.dart';
import 'package:flutter_auth_demo_with_bloc/data/repository/validation_repository.dart';
import 'package:formz/formz.dart';

class SignupValidationState extends Equatable {
  SignupValidationState({
    this.fname = const Fname.pure(),
    this.lname = const Lname.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.cnfpassword = const CnfPassword.pure(),
    this.status = FormzStatus.pure,
  });

  final Fname fname;
  final Lname lname;
  final Email email;
  final Password password;
  final CnfPassword cnfpassword;
  final FormzStatus status;

  SignupValidationState copyWith({
    Fname? fname,
    Lname? lname,
    Email? email,
    Password? password,
    CnfPassword? cnfpassword,
    FormzStatus? status,
  }) {
    return SignupValidationState(
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      email: email ?? this.email,
      password: password ?? this.password,
      cnfpassword: cnfpassword ?? this.cnfpassword,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [fname, lname, email, password, cnfpassword, status];
}
