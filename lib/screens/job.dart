import 'package:flutter/material.dart';
import 'package:grafter/shared/custom_app_bar.dart';

class Job extends StatefulWidget {
  const Job({Key? key}) : super(key: key);

  @override
  _JobState createState() => _JobState();
}

class _JobState extends State<Job> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Text('Job Name Here'),
            const Text('Job Address Here'),
            ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Text(
                    'Material Name  Material Cost: \$1  Quantity: $index');
              },
            ),
            const Text('Total: X'),
            Row(
              children: <Widget>[
                Expanded(
                    child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        'images/Icon-192.png',
                        height: 100.0,
                        width: 100.0,
                      );
                    },
                  ),
                )),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            )
          ],
        ),
      ),
    );
  }
}
