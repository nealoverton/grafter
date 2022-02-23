import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grafter/models/job.dart';

class DatabaseService {
  final String? uid = FirebaseAuth.instance.currentUser!.uid;

  // final String testJobuid = "GWE6pZr0uEDfcxzGkL0s";

  // collection reference
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<Object?> getUserData() async {
    DocumentSnapshot snap = await _usersCollection.doc(uid).get();

    // returns user's name and company
    return snap.data();
  }

  Future createUser() async {
    // temp values in set until fields added to registration

    return await _usersCollection
        .doc(uid)
        .set({"name": "new name", "company": "company"});
  }

  Future updateUserData(String name, String company) async {
    return await _usersCollection
        .doc(uid)
        .set({"name": name, "company": company});
  }

  Future<List<Job>> getJobs() async {
    final _jobCollection =
        await _usersCollection.doc(uid).collection("jobs").get();

    // return a list of all jobs against user
    return _jobCollection.docs.map((doc) {
      return Job(
          name: doc.get('name'),
          address: 'some address',
          notes: doc.get('notes'),
          jobMaterials: [],
          attachments: []);
    }).toList();
  }

  List<Job> _jobListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      print(doc.get('name'));
      return Job(
          name: doc.get('name'),
          address: 'some address',
          notes: doc.get('notes'),
          jobMaterials: [],
          attachments: []);
    }).toList();
  }

  Future addJob() async {
    // adds job to user
    return await _usersCollection
        .doc(uid)
        .collection("jobs")
        .add({"estimate": 0, "isLive": false, "jobNotes": "", "title": ""});
  }

  Future deleteJob(jobId) async {
    // deletes job from user
    final DocumentReference _jobCollection =
        await _usersCollection.doc(uid).collection("jobs").doc(jobId);

    FirebaseFirestore.instance.runTransaction(
        (transaction) async => {transaction.delete(_jobCollection)});
  }

  Stream<List<Job>> get jobs {
    final test = _usersCollection
        .doc(uid)
        .collection('jobs')
        .snapshots()
        .map(_jobListFromSnapshot);
    print(test);
    return test;
  }
}
