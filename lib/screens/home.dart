import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/services/auth_services.dart';
import 'package:hdtc_project/services/pdf_services.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              print('pressed');
              await PdfAPI.GeneratePdfAsBytes();
              print('done');
            },
            child: const Text('Download PDF')),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        try {
          _authService.signOut();
        } catch (e) {
          print('Catched Error = ${e.toString()}');
        }
      }),
    );
  }

  // Future<void> saveAndLaunchFileWeb(List<int> bytes, String fileName) async {
  //   AnchorElement(
  //       href:
  //           "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
  //     ..setAttribute("download", fileName)
  //     ..click();
  // }
}
