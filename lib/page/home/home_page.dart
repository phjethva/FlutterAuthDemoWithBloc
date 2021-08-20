import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/auth/auth_bloc.dart';
import 'package:flutter_auth_demo_with_bloc/bloc/auth/auth_event.dart';
import 'package:flutter_auth_demo_with_bloc/page/home/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter AuthDemoWithBLOC - Home')),
      body: Center(
        child: Profile(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AuthBloc>().add(UserLogout());
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
