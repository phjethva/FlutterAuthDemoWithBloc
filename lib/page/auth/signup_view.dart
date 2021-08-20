import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/auth/auth_bloc.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/auth/auth_event.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/auth/auth_state.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/validation/signup/signup_validation_bloc.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/validation/signup/signup_validation_event.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/validation/signup/signup_validation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _fnameFocusNode = FocusNode();
  final _lnameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _cnfPasswordFocusNode = FocusNode();
  final _authBtnController = RoundedLoadingButtonController();

  late bool _passwordVisible;
  late bool _cnfPasswordVisible;

  @override
  void initState() {
    super.initState();
    _fnameFocusNode.addListener(() {
      if (!_fnameFocusNode.hasFocus) {
        context.read<SignupValidationBloc>().add(FnameUnfocused());
        FocusScope.of(context).requestFocus(_lnameFocusNode);
      }
    });
    _lnameFocusNode.addListener(() {
      if (!_lnameFocusNode.hasFocus) {
        context.read<SignupValidationBloc>().add(LnameUnfocused());
        FocusScope.of(context).requestFocus(_emailFocusNode);
      }
    });
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<SignupValidationBloc>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<SignupValidationBloc>().add(PasswordUnfocused());
        FocusScope.of(context).requestFocus(_cnfPasswordFocusNode);
      }
    });
    _cnfPasswordFocusNode.addListener(() {
      if (!_cnfPasswordFocusNode.hasFocus) {
        context.read<SignupValidationBloc>().add(CnfPasswordUnfocused());
      }
    });

    _passwordVisible = false;
    _cnfPasswordVisible = false;
  }

  @override
  void dispose() {
    _fnameFocusNode.dispose();
    _lnameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _cnfPasswordFocusNode.dispose();
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
        BlocListener<SignupValidationBloc, SignupValidationState>(
          listener: (context, state) {
            if (state.status.isSubmissionSuccess) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              context.read<AuthBloc>().add(UserSignup(
                  fname: state.fname.value,
                  lname: state.lname.value,
                  email: state.email.value,
                  password: state.password.value,
                  cnfpassword: state.cnfpassword.value));
            }
          },
        ),
      ],
      child: _signupForm(),
    );
  }

  Widget _signupForm() {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: kIsWeb ? 450.0 : 288.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: _fnameField(),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                    flex: 1,
                    child: _lnameField(),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              _emailField(),
              SizedBox(
                height: 10.0,
              ),
              _passwordField(),
              SizedBox(
                height: 10.0,
              ),
              _cnfPasswordField(),
              SizedBox(
                height: 10.0,
              ),
              _signupField(),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fnameField() {
    return BlocBuilder<SignupValidationBloc, SignupValidationState>(builder: (context, state) {
      return TextFormField(
        //initialValue: state.fname.value,
        focusNode: _fnameFocusNode,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          context.read<SignupValidationBloc>().add(FnameChanged(fname: value));
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
            Icons.face,
            color: Colors.blue,
          ),
          hintText: 'John',
          hintStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.normal, fontSize: 14.0),
          hintMaxLines: 1,
          errorText: state.fname.invalid ? 'Must be alphabet and at least 3 characters long!' : null,
          errorMaxLines: 2,
          errorStyle: TextStyle(color: Colors.red, fontStyle: FontStyle.italic, fontSize: 12.0),
        ),
      );
    });
  }

  Widget _lnameField() {
    return BlocBuilder<SignupValidationBloc, SignupValidationState>(builder: (context, state) {
      return TextFormField(
        //initialValue: state.lname.value,
        focusNode: _lnameFocusNode,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          context.read<SignupValidationBloc>().add(LnameChanged(lname: value));
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
          hintText: 'Doe',
          hintStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.normal, fontSize: 14.0),
          hintMaxLines: 1,
          errorText: state.lname.invalid ? 'Must be alphabet and at least 3 characters long!' : null,
          errorMaxLines: 2,
          errorStyle: TextStyle(color: Colors.red, fontStyle: FontStyle.italic, fontSize: 12.0),
        ),
      );
    });
  }

  Widget _emailField() {
    return BlocBuilder<SignupValidationBloc, SignupValidationState>(builder: (context, state) {
      return TextFormField(
        //initialValue: state.email.value,
        focusNode: _emailFocusNode,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          context.read<SignupValidationBloc>().add(EmailChanged(email: value));
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
    return BlocBuilder<SignupValidationBloc, SignupValidationState>(builder: (context, state) {
      return TextFormField(
        //initialValue: state.password.value,
        focusNode: _passwordFocusNode,
        obscureText: !_passwordVisible,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          context.read<SignupValidationBloc>().add(PasswordChanged(password: value));
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

  Widget _cnfPasswordField() {
    return BlocBuilder<SignupValidationBloc, SignupValidationState>(builder: (context, state) {
      return TextFormField(
        //initialValue: state.cnfpassword.value,
        focusNode: _cnfPasswordFocusNode,
        obscureText: !_cnfPasswordVisible,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          context.read<SignupValidationBloc>().add(CnfPasswordChanged(cnfpassword: value));
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
              _cnfPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.blue,
            ),
            onPressed: () {
              setState(() {
                _cnfPasswordVisible = !_cnfPasswordVisible;
              });
            },
          ),
          hintText: '123456',
          hintStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.normal, fontSize: 14.0),
          hintMaxLines: 1,
          errorText: state.cnfpassword.invalid ? 'Confirm password do not match with password!' : null,
          errorMaxLines: 2,
          errorStyle: TextStyle(color: Colors.red, fontStyle: FontStyle.italic, fontSize: 12.0),
        ),
      );
    });
  }

  Widget _signupField() {
    return BlocBuilder<SignupValidationBloc, SignupValidationState>(builder: (context, state) {
      return RoundedLoadingButton(
        controller: _authBtnController,
        width: 150.0,
        height: 45.0,
        color: Colors.blue,
        valueColor: Colors.white,
        child: Text(
          'Signup',
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal, fontSize: 14.0),
        ),
        onPressed: state.status.isValidated ? () => context.read<SignupValidationBloc>().add(SignupFormSubmitted()) : null,
      );
    });
  }
}
