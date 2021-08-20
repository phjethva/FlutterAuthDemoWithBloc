import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/auth/auth_bloc.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/auth/auth_event.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/auth/auth_state.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/validation/login/login_validation_bloc.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/validation/login/login_validation_event.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/validation/login/login_validation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _authBtnController = RoundedLoadingButtonController();

  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<LoginValidationBloc>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<LoginValidationBloc>().add(PasswordUnfocused());
      }
    });

    _passwordVisible = false;
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              _authBtnController.reset();
            }
            if (state is AuthError) {
              _authBtnController.reset();
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
            }
          },
        ),
        BlocListener<LoginValidationBloc, LoginValidationState>(
          listener: (context, state) {
            if (state.status.isSubmissionSuccess) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              context.read<AuthBloc>().add(UserLogin(email: state.email.value, password: state.password.value));
            }
          },
        ),
      ],
      child: _loginForm(),
    );
  }

  Widget _loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _emailField(),
        const SizedBox(
          height: 10.0,
        ),
        _passwordField(),
        const SizedBox(
          height: 10.0,
        ),
        _loginField(),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Widget _emailField() {
    return BlocBuilder<LoginValidationBloc, LoginValidationState>(builder: (context, state) {
      return TextFormField(
        //initialValue: state.email.value,
        focusNode: _emailFocusNode,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          context.read<LoginValidationBloc>().add(EmailChanged(email: value));
        },
        textInputAction: TextInputAction.next,
        style: TextStyle(color: Colors.blue, fontStyle: FontStyle.normal, fontSize: 14.0),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFBBDEFB),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide.none,
          ),
          isDense: true,
          contentPadding: EdgeInsets.all(8),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.blue,
          ),
          hintText: 'john.doe@xyz.com',
          hintStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.normal, fontSize: 14.0),
          hintMaxLines: 1,
          errorText: state.email.invalid ? 'Email entered is not valid!' : null,
          errorMaxLines: 2,
          errorStyle: TextStyle(color: Colors.red, fontStyle: FontStyle.italic, fontSize: 12.0),
        ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginValidationBloc, LoginValidationState>(builder: (context, state) {
      return TextFormField(
        //initialValue: state.password.value,
        focusNode: _passwordFocusNode,
        obscureText: !_passwordVisible,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          context.read<LoginValidationBloc>().add(PasswordChanged(password: value));
        },
        textInputAction: TextInputAction.done,
        style: TextStyle(color: Colors.blue, fontStyle: FontStyle.normal, fontSize: 14.0),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFBBDEFB),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide.none,
          ),
          isDense: true,
          contentPadding: EdgeInsets.all(8),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.blue,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.blue,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          hintText: '123456',
          hintStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.normal, fontSize: 14.0),
          hintMaxLines: 1,
          errorText: state.password.invalid ? 'Must be alphanumeric and at least 8 characters long!' : null,
          errorMaxLines: 2,
          errorStyle: TextStyle(color: Colors.red, fontStyle: FontStyle.italic, fontSize: 12.0),
        ),
      );
    });
  }

  Widget _loginField() {
    return BlocBuilder<LoginValidationBloc, LoginValidationState>(builder: (context, state) {
      return RoundedLoadingButton(
        controller: _authBtnController,
        width: 150.0,
        height: 45.0,
        color: Colors.blue,
        valueColor: Colors.white,
        child: Text(
          'Login',
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal, fontSize: 14.0),
        ),
        onPressed: state.status.isValidated ? () => context.read<LoginValidationBloc>().add(LoginFormSubmitted()) : null,
      );
    });
  }
}
