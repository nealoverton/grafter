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

    return MaterialApp(
      home: Scaffold(
          appBar: CustomAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.all(60),
                child: FlatButton(
                  child: Text(
                    'My Jobs',
                    style: TextStyle(fontSize: 40.0),
                  ),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.all(60),
                child: FlatButton(
                  child: Text(
                    'Sketch',
                    style: TextStyle(fontSize: 40.0),
                  ),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.all(60),
                child: FlatButton(
                  child: Text(
                    'Diary',
                    style: TextStyle(fontSize: 40.0),
                  ),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              ),
            ])),
          )),

    );
  }
}
