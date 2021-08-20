import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/auth/auth_event.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/auth/auth_state.dart';
import 'package:flutter_auth_demo_with_bloc/data/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepo;

  AuthBloc({required AuthRepository authRepo})
      : _authRepo = authRepo,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    yield AuthLoading();

    if (event is AppStarted) {
      await Future.delayed(Duration(milliseconds: 500));
      try {
        final user = await _authRepo.getCurrentUser();
        if (user != null) {
          yield UserAuthenticated(user: user);
        } else {
          yield UserNotAuthenticated();
        }
      } catch (e) {
        yield UserNotAuthenticated();
      }
    }

    if (event is UserLogin) {
      try {
        await Future.delayed(Duration(milliseconds: 500));
        final user = await _authRepo.loginWithEmailPassword(email: event.email, password: event.password);
        if (user != null) {
          yield AuthSuccess(user: user);
        } else {
          yield AuthError(errorMessage: 'User not available.');
        }
      } on FirebaseAuthException catch (e) {
        yield AuthError(errorMessage: e.message.toString());
      } catch (e) {
        yield AuthError(errorMessage: 'An unknown error occurred.');
      }
    }

    if (event is UserSignup) {
      try {
        await Future.delayed(Duration(milliseconds: 500));
        final user = await _authRepo.signupWithEmailPassword(email: event.email, password: event.password);
        if (user != null) {
          var uid = user.uid;
          final userCreate = await _authRepo.signupWithProfile(uid: uid, fname: event.fname, lname: event.lname, email: event.email);
          if (userCreate) {
            yield AuthSuccess(user: user);
          } else {
            yield AuthError(errorMessage: 'User not available.');
          }
        } else {
          yield AuthError(errorMessage: 'User not available.');
        }
      } on FirebaseAuthException catch (e) {
        yield AuthError(errorMessage: e.message.toString());
      } catch (e) {
        yield AuthError(errorMessage: 'An unknown error occurred.');
      }
    }

    if (event is UserLogout) {
      await Future.delayed(Duration(milliseconds: 500));
      await _authRepo.logout();
      yield UserNotAuthenticated();
    }
  }
}
