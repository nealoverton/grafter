import 'package:flutter/material.dart';
import 'package:grafter/models/job.dart';
import 'package:grafter/models/job_material.dart';
import 'package:grafter/screens/diary.dart';
import 'package:grafter/shared/custom_app_bar.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:grafter/shared/fullscreen_image.dart';
import 'package:image_picker/image_picker.dart';

class JobViewer extends StatefulWidget {
  const JobViewer({Key? key}) : super(key: key);

  @override
  _JobViewerState createState() => _JobViewerState();
}

class _JobViewerState extends State<JobViewer> {
  List<File> attachments = [];
  List<JobMaterial> testMaterials = [
    JobMaterial(name: 'ball of twine', price: 0.89),
    JobMaterial(name: 'conical flask', price: 2.50),
    JobMaterial(name: 'Dead Sea water 1l', price: 3.76),
  ];

  Future? pickImage(imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      final temporaryImage = File(image.path);
      setState(() {
        attachments.add(temporaryImage);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Job testJob = Job(
        name: 'Create perpetual motion device',
        address: 'My place',
        description: 'If I fiddle enough I must crack it eventually',
        jobMaterials: testMaterials,
        attachments: attachments);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(testJob.name),
            Text(testJob.address),
            Text(testJob.description),
            ListView.builder(
              itemCount: testJob.jobMaterials.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(testJob.jobMaterials[index].name),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text('£' +
                              testJob.jobMaterials[index].price.toString()),
                          Text(testJob.jobMaterials[index].name),
                        ])
                  ],
                );
              },
            ),
            const Text('Total: X'),
            Row(
              children: <Widget>[
                Expanded(
                    child: SizedBox(
                  height: 100.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: attachments.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreenImage(
                                      imageFile: attachments[index],
                                    )),
                          );
                        },
                        child: Image.file(
                          attachments[index],
                          height: 100.0,
                          width: 100.0,
                        ),
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
