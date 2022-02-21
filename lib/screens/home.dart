import 'package:flutter/material.dart';
import 'package:grafter/screens/job.dart';
import 'package:grafter/services/auth.dart';
import 'package:grafter/shared/custom_app_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: ElevatedButton(
          child: const Text('View Job'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Job()),
            );
          },
        ),
      ),
    );
  }
}
