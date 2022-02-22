import 'dart:io';

import 'package:grafter/models/job_material.dart';

class Job {
  final String name;
  final String address;
  final String description;
  final List<JobMaterial> jobMaterials;
  final List<File> attachments;

  Job(
      {required this.name,
      required this.address,
      required this.description,
      required this.jobMaterials,
      required this.attachments});
}
