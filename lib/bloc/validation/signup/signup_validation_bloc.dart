import 'package:flutter_auth_demo_with_bloc/bloc/validation/signup/signup_validation_event.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/validation/signup/signup_validation_state.dart';
import 'package:flutter_auth_demo_with_bloc/data/repository/validation_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignupValidationBloc extends Bloc<SignupValidationEvent, SignupValidationState> {
  SignupValidationBloc() : super(SignupValidationState());

  @override
  Stream<SignupValidationState> mapEventToState(SignupValidationEvent event) async* {
    if (event is FnameChanged) {
      final fname = Fname.dirty(event.fname);
      yield state.copyWith(
        fname: fname.valid ? fname : Fname.pure(event.fname),
        status: Formz.validate([fname, state.lname, state.email, state.password, state.cnfpassword]),
      );
    } else if (event is LnameChanged) {
      final lname = Lname.dirty(event.lname);
      yield state.copyWith(
        lname: lname.valid ? lname : Lname.pure(event.lname),
        status: Formz.validate([state.fname, lname, state.email, state.password, state.cnfpassword]),
      );
    } else if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate([state.fname, state.lname, email, state.password, state.cnfpassword]),
      );
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      yield state.copyWith(
        password: password.valid ? password : Password.pure(event.password),
        status: Formz.validate([state.fname, state.lname, state.email, password, state.cnfpassword]),
      );
    } else if (event is CnfPasswordChanged) {
      final cnfpassword = CnfPassword.dirty(event.cnfpassword);
      yield state.copyWith(
        cnfpassword: cnfpassword.valid ? cnfpassword : CnfPassword.pure(event.cnfpassword),
        status: Formz.validate([state.fname, state.lname, state.email, state.password, cnfpassword]),
      );
    } else if (event is FnameUnfocused) {
      final fname = Fname.dirty(state.fname.value);
      yield state.copyWith(
        fname: fname,
        status: Formz.validate([fname, state.lname, state.email, state.password, state.cnfpassword]),
      );
    } else if (event is LnameUnfocused) {
      final lname = Lname.dirty(state.lname.value);
      yield state.copyWith(
        lname: lname,
        status: Formz.validate([state.fname, lname, state.email, state.password, state.cnfpassword]),
      );
    } else if (event is EmailUnfocused) {
      final email = Email.dirty(state.email.value);
      yield state.copyWith(
        email: email,
        status: Formz.validate([state.fname, state.lname, email, state.password, state.cnfpassword]),
      );
    } else if (event is PasswordUnfocused) {
      final password = Password.dirty(state.password.value);
      yield state.copyWith(
        password: password,
        status: Formz.validate([state.fname, state.lname, state.email, password, state.cnfpassword]),
      );
    } else if (event is CnfPasswordUnfocused) {
      final cnfpassword = CnfPassword.dirty(state.cnfpassword.value);
      yield state.copyWith(
        cnfpassword: cnfpassword,
        status: Formz.validate([state.fname, state.lname, state.email, state.password, cnfpassword]),
      );
    } else if (event is SignupFormSubmitted) {
      final fname = Fname.dirty(state.fname.value);
      final lname = Lname.dirty(state.lname.value);
      final email = Email.dirty(state.email.value);
      final password = Password.dirty(state.password.value);
      final cnfpassword = CnfPassword.dirty(state.cnfpassword.value);
      yield state.copyWith(
        fname: fname,
        lname: lname,
        email: email,
        password: password,
        cnfpassword: cnfpassword,
        status: Formz.validate([fname, lname, email, password, cnfpassword]),
      );
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        await Future<void>.delayed(Duration(seconds: 1));
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      }
    }
  }
}
