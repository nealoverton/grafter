import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grafter/shared/custom_app_bar.dart';
import 'package:image_picker/image_picker.dart';

class Job extends StatefulWidget {
  const Job({Key? key}) : super(key: key);

  @override
  _JobState createState() => _JobState();
}

class _JobState extends State<Job> {
  List<File> images = [];

  Future? pickImage(imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      final temporaryImage = File(image.path);
      setState(() {
        images.add(temporaryImage);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                    onPressed: () => pickImage(ImageSource.camera),
                    icon: Icon(Icons.add_a_photo),
                    label: Text('')),
                TextButton.icon(
                    onPressed: () => pickImage(ImageSource.gallery),
                    icon: Icon(Icons.photo_size_select_actual),
                    label: Text('')),
                TextButton.icon(
                    onPressed: () => {},
                    icon: Icon(Icons.note_alt),
                    label: Text(''))
              ],
            )
          ],
        ),
      ),
    );
  }
}
