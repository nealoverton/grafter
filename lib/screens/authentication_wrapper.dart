import 'package:flutter/material.dart';
import 'package:graftr/screens/login.dart';
import 'package:graftr/screens/register.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool newUser = true;

  void toggleView() {
    setState(() {
      newUser = !newUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (newUser) {
      return Register(toggleView: toggleView);
    } else {
      return LogIn(toggleView: toggleView);
    }
  }
}
