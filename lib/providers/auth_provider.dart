import 'package:firebase_auth/firebase_auth.dart';
import 'package:hdtc_project/models/user.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<AppUser?> get getUser {
    return _auth.authStateChanges().map(_appUserFromFirebase);
  }

  AppUser? _appUserFromFirebase(User? firebaseUser) {
    if (firebaseUser != null) {
      return AppUser(
          id: firebaseUser.uid,
          // TODO: userName fix => firebaseuser.displayName
          email: firebaseUser.email!);
    } else {
      return null;
    }
  }
}
