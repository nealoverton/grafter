import 'package:firebase_auth/firebase_auth.dart';
import 'package:grafter/models/app_user.dart';
import "package:grafter/services/database.dart";

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      User? user = result.user;
      await DatabaseService(uid: user!.uid)
          .updateUserData("name", "company"); // temp values
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      User? user = result.user;

      // to set DB instance of signed in user
      DatabaseService(uid: user!.uid);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signOutUser() async {
    try {
      _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }
}
