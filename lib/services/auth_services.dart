import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/models/user.dart';
import 'package:hdtc_project/wrapper.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String userName,
      required BuildContext context,
      required String role}) async {
    try {
      final _auth = FirebaseAuth.instance;
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _firebaseFirestore.collection('users').doc(authResult.user!.uid).set(
          AppUser(
                  id: authResult.user!.uid,
                  userName: userName,
                  role: role,
                  email: authResult.user!.email!)
              .toJson());

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('تم إنشاء الحساب بنجاح'),
                actions: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('موافق'))
                ],
              ));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('حدث خطأ أثناء إنشاء الحساب'),
                content:
                    const Text('الرجاء التأكد من المعلومات أو المحاولة لاحقاً'),
                actions: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('موافق'))
                ],
              ));
    }
  }

  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        final auth = FirebaseAuth.instance;
        print('Sign In Success ${auth.currentUser?.email}');
      });
    } catch (e) {
      print('Catched Error Message in sign in = ${e.toString()}');
    }
  }

  Future signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Wrapper()),
        (route) => false);
  }
}
