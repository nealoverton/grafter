import 'dart:io';

import 'package:grafter/models/job_material.dart';

class Job {
  final String name;
  final String address;
  final String notes;
  final List<JobMaterial> jobMaterials;
  final List<File> attachments;

  Job(
      {required this.name,
      required this.address,
      required this.notes,
      required this.jobMaterials,
      required this.attachments});
}
