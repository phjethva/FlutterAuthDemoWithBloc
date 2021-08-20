import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/auth/auth_bloc.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/auth/auth_event.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/auth/auth_state.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/validation/login/login_validation_bloc.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/validation/signup/signup_validation_bloc.dart';
import 'package:flutter_auth_demo_with_bloc/data/repository/auth_repository.dart';
import 'package:flutter_auth_demo_with_bloc/page/auth/auth_page.dart';
import 'package:flutter_auth_demo_with_bloc/page/home/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      create: (context) {
        return AuthRepository(FirebaseAuth.instance);
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final authRepo = RepositoryProvider.of<AuthRepository>(context);
              return AuthBloc(authRepo: authRepo)..add(AppStarted());
            },
          ),
          BlocProvider(
            create: (context) {
              return SignupValidationBloc();
            },
          ),
          BlocProvider(
            create: (context) {
              return LoginValidationBloc();
            },
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter AuthDemoWithBLOC',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          //home: Home(),
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is UserAuthenticated || state is AuthSuccess) {
                return Home();
              }
              return Auth();
            },
          ),
        ),
      ),
    );
  }
}
