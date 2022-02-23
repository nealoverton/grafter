import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String? uid = FirebaseAuth.instance.currentUser!.uid;
  // final String testJobuid = "GWE6pZr0uEDfcxzGkL0s";
  

  // collection reference
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection("users");

  Future<Object?> getUserData() async {
    DocumentSnapshot snap = await _usersCollection.doc(uid).get();

    // returns user's name and company
    return snap.data();
  }

    Future createUser(newUserUid) async {

    // temp values in set until fields added to registration
    return await _usersCollection
        .doc(newUserUid)
        .set({"name": "name", "company": "company"});
  }


  Future updateUserData(String name, String company) async {
    return await _usersCollection
        .doc(uid)
        .set({"name": name, "company": company});
  }

  Future getJobs() async {
    final _jobCollection =
        await _usersCollection.doc(uid).collection("jobs").get();

    // return a list of all jobs against user
    return _jobCollection.docs.map((doc) => {doc.data()}).toList();
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

  Future testFunc() async {
    User user = FirebaseAuth.instance.currentUser!;
    String? uid = user.uid;
    print(uid);
  }
}
