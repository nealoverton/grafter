import 'package:flutter/material.dart';
import 'package:grafter/services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton.icon(
          onPressed: AuthService().signOutUser,
          icon: const Icon(Icons.person),
          label: const Text('Logout')),
    );
  }
}
