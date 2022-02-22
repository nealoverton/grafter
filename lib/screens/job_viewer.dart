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
    JobMaterial(name: 'ball of twine', price: 0.89, quantity: 1),
    JobMaterial(name: 'conical flask', price: 2.50, quantity: 3),
    JobMaterial(name: 'Dead Sea water 1l', price: 3.76, quantity: 7),
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

    double totalPrice = 0.00;
    testMaterials.forEach((jobMaterial) {
      totalPrice += jobMaterial.price * jobMaterial.quantity;
    });

    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Text(
              testJob.name,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              testJob.address,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              testJob.description,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            Column(
              children: <Widget>[
                ...testJob.jobMaterials
                    .map((jobMaterial) => Column(children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(jobMaterial.name),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('£' + jobMaterial.price.toString()),
                              Text('Quantity: ' +
                                  jobMaterial.quantity.toString())
                            ],
                          )
                        ]))
                    .toList()
              ],
            ),
            // ListView.builder(
            //   itemCount: testJob.jobMaterials.length,
            //   shrinkWrap: true,
            //   itemBuilder: (context, index) {
            //     return Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         Text(testJob.jobMaterials[index].name),
            //         Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceAround,
            //             children: <Widget>[
            //               Text('£' +
            //                   testJob.jobMaterials[index].price.toString()),
            //               Text(testJob.jobMaterials[index].name),
            //             ])
            //       ],
            //     );
            //   },
            // ),
            SizedBox(
              height: 20.0,
            ),
            Text('Total: £' + totalPrice.toString(),
                textAlign: TextAlign.center),
            SizedBox(
              height: 30.0,
            ),

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
                      return Row(children: [
                        GestureDetector(
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
                        ),
                        SizedBox(
                          width: 10.0,
                        )
                      ]);
                    },
                  ),
                )),
              ],
            ),
            SizedBox(
              height: 20.0,
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
