import 'package:flutter/material.dart';

import 'package:grafter/screens/diary.dart';
import 'package:grafter/screens/job_viewer.dart';
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
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: CustomAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
                child: Column(children: <Widget>[
              Container(
                margin: const EdgeInsets.all(60),
                color: Colors.blueAccent,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const JobViewer()),
                    );
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  child: const Text('My Jobs', style: TextStyle(fontSize: 40)),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(60),
                color: Colors.blueAccent,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  child:
                      const Text('Sketchpad', style: TextStyle(fontSize: 40)),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(60),
                color: Colors.blueAccent,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Calendar()),
                    );
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  child: const Text('My Diary', style: TextStyle(fontSize: 40)),
                ),
              ),
            ])),
          )),
    );
  }
}
