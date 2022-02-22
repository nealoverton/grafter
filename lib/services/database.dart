import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseService {
  // temp values until registered id is
  final String? uid;
  // final String testJobuid = "GWE6pZr0uEDfcxzGkL0s";
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection("users");

  Future<Object?> getUserData() async {
    DocumentSnapshot snap = await _usersCollection.doc(uid).get();

    // returns user's name and company
    return snap.data();
  }

  Future updateUserData(String name, String company) async {
    return await _usersCollection
        .doc(uid)
        .set({"name": name, "company": company});
  }

  Future getJobs() async {
    final _jobCollection =
        await _usersCollection.doc(uid).collection("jobs").get();

    // return a list of all jobs against  user
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
        (transaction) async => {await transaction.delete(_jobCollection)});
  }
}
