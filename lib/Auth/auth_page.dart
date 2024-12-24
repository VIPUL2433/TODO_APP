import 'package:flutter/material.dart';
import 'package:task_app/login.dart';
import 'package:task_app/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? Key}) : super(key: Key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //intially show the login page
  bool showMyLogin = true;

  void toggleScreens() {
    setState(() {
      showMyLogin = !showMyLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showMyLogin) {
      return MyLogin(
        showMySignup: toggleScreens,
      );
    } else {
      return MySignup(
        showMyLogin: toggleScreens,
      );
    }
  }
}
