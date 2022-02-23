import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grafter/models/app_user.dart';
import 'package:grafter/screens/logged_in_wrapper.dart';
import 'package:grafter/services/auth.dart';
import 'package:grafter/shared/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>(
        create: (_) => AuthService().user,
        initialData: null,
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Grafter',
            theme: CustomTheme.grafterTheme,
            home: LoggedInWrapper(),
          );
        });
  }
}