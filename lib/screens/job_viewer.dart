import 'package:flutter/material.dart';
import 'package:grafter/models/job.dart';
import 'package:grafter/models/job_material.dart';
import 'package:grafter/screens/diary.dart';
import 'package:grafter/services/database.dart';
import 'package:grafter/shared/custom_app_bar.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:grafter/shared/fullscreen_image.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

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
    final jobList = Provider.of<List<Job>?>(context);

    if (jobList != null) {
      jobList.forEach((element) {
        print(jobList[0]);
      });
    }

    Job testJob = Job(
        name: 'Create perpetual motion device',
        address: 'My place',
        notes: 'If I fiddle enough I must crack it eventually',
        jobMaterials: testMaterials,
        attachments: attachments);

    double totalPrice = 0.00;
    testMaterials.forEach((jobMaterial) {
      totalPrice += jobMaterial.price * jobMaterial.quantity;
    });

    return Scaffold(
      appBar: CustomAppBar(),
      body: jobList == null
          ? Text('Loading')
          : Container(
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: ListView(
                children: <Widget>[
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    testJob.name,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    testJob.address,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    testJob.notes,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20.0,
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.file(
                                    attachments[index],
                                    height: 100.0,
                                    width: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              )
                            ]);
                          },
                        ),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                          onPressed: () => pickImage(ImageSource.camera),
                          icon: const Icon(Icons.add_a_photo),
                          label: const Text('')),
                      TextButton.icon(
                          onPressed: () => pickImage(ImageSource.gallery),
                          icon: const Icon(Icons.photo_size_select_actual),
                          label: const Text('')),
                      TextButton.icon(
                          onPressed: () => {},
                          icon: const Icon(Icons.note_alt),
                          label: const Text(''))
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      ...testJob.jobMaterials
                          .map((jobMaterial) => Column(children: [
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(jobMaterial.name),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('£' + jobMaterial.price.toString()),
                                    Row(
                                      children: [
                                        Text('Quantity: ' +
                                            jobMaterial.quantity.toString()),
                                      ],
                                    )
                                  ],
                                )
                              ]))
                          .toList()
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text('Total: £' + totalPrice.toString(),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
    );
  }
}
