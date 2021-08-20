import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_auth_demo_with_bloc/page/auth/login_view.dart';
import 'package:flutter_auth_demo_with_bloc/page/auth/signup_view.dart';

class Auth extends StatefulWidget {
  Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  var _isSignup = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade300,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              width: kIsWeb ? 350.0 : double.maxFinite,
              height: 50.0,
              margin: EdgeInsets.fromLTRB(kIsWeb ? 0.0 : 10.0, 50.0, kIsWeb ? 0.0 : 10.0, 0.0),
              child: Center(
                child: Text(
                  'Flutter AuthDemoWithBLOC',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 350),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: kIsWeb ? 0.0 : 10.0),
                    width: kIsWeb ? 350.0 : double.maxFinite,
                    height: _isSignup
                        ? kIsWeb
                            ? 450.0
                            : 338.0
                        : 280.0,
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TabBar(
                            onTap: (index) => setState(() {
                              (index != 0) ? _isSignup = true : _isSignup = false;
                            }),
                            indicatorColor: Colors.blue,
                            tabs: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14.0,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Signup',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14.0,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: _isSignup ? Signup() : Login(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 2.0),
              ),
              width: double.maxFinite,
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Description:\nThis is an example of authentication process & user management with Firebase to understand BLOC pattern in Flutter mobile & website.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ));
  }
}
