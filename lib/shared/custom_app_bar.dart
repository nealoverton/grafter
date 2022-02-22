import 'package:flutter/material.dart';
import 'package:grafter/services/auth.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({Key? key})
      : super(
            key: key,
            title: const Text('Grafter'),
            backgroundColor: Colors.black,
            actions: [
              TextButton.icon(
                  onPressed: AuthService().signOutUser,
                  icon: const Icon(Icons.person),
                  label: const Text('Logout')),
            ]);
}
