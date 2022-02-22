import 'package:flutter/material.dart';
import 'package:grafter/models/app_user.dart';
import 'package:grafter/screens/authentication/authentication_wrapper.dart';
import 'package:grafter/screens/home.dart';
import 'package:provider/provider.dart';

class LoggedInWrapper extends StatelessWidget {
  const LoggedInWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    if (user == null) {
      return const Authenticate();
    } else {
      return const Home();
    }
  }
}
