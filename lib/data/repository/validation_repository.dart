import 'package:formz/formz.dart';

enum FnameValidationError { invalid }
enum LnameValidationError { invalid }
enum EmailValidationError { invalid }
enum PasswordValidationError { invalid }
enum CnfPasswordValidationError { invalid }

class Fname extends FormzInput<String, FnameValidationError> {
  const Fname.pure([String value = '']) : super.pure(value);

  const Fname.dirty([String value = '']) : super.dirty(value);

  static final _fNameRegex = RegExp(
    r'^(?!.*[^a-zA-Z]).{3,10}$',
  );

  @override
  FnameValidationError? validator(String? value) {
    return _fNameRegex.hasMatch(value ?? '') ? null : FnameValidationError.invalid;
  }
}

class Lname extends FormzInput<String, LnameValidationError> {
  const Lname.pure([String value = '']) : super.pure(value);

  const Lname.dirty([String value = '']) : super.dirty(value);

  static final _lNameRegex = RegExp(
    r'^(?!.*[^a-zA-Z]).{3,10}$',
  );

  @override
  LnameValidationError? validator(String? value) {
    return _lNameRegex.hasMatch(value ?? '') ? null : LnameValidationError.invalid;
  }
}

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure([String value = '']) : super.pure(value);

  const Email.dirty([String value = '']) : super.dirty(value);

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegex.hasMatch(value ?? '') ? null : EmailValidationError.invalid;
  }
}

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([String value = '']) : super.pure(value);

  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegex = RegExp(r'^(?=\D*\d)(?=.*[A-Za-z])[\w~@#$%^&*+=`|{}:;!.?\"()\[\]-]{8,25}$');

  @override
  PasswordValidationError? validator(String? value) {
    return _passwordRegex.hasMatch(value ?? '') ? null : PasswordValidationError.invalid;
  }
}

class CnfPassword extends FormzInput<String, CnfPasswordValidationError> {
  const CnfPassword.pure([String value = '']) : super.pure(value);

  const CnfPassword.dirty([String value = '']) : super.dirty(value);

  static final _cnfPasswordRegex = RegExp(r'^(?=\D*\d)(?=.*[A-Za-z])[\w~@#$%^&*+=`|{}:;!.?\"()\[\]-]{8,25}$');

  @override
  CnfPasswordValidationError? validator(String? value) {
    return _cnfPasswordRegex.hasMatch(value ?? '') ? null : CnfPasswordValidationError.invalid;
  }
}
