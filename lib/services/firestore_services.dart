import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hdtc_project/models/university.dart';
import 'package:hdtc_project/models/user_data.dart';
import 'package:hdtc_project/utils.dart';

class FireStoreServices {
  static final firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? id;
  FireStoreServices({this.id});

  static Future<bool> addUniversity(
      {required String collectionPath, required University uniData}) async {
    final doc = await firebaseFirestore
        .collection(collectionPath)
        .doc(uniData.name)
        .get();
    try {
      if (doc.exists) {
        return false;
      } else {
        await firebaseFirestore
            .collection(collectionPath)
            .doc(uniData.name)
            .set(uniData.toMap(), SetOptions(merge: true));
        return true;
      }
    } catch (e) {
      print('Catched Error Message inside add Uni Method = ${e.toString()}');
      return false;
    }
  }

  static Future addField(
      {required String collectionPath,
      required String docId,
      required String field}) async {
    final doc = firebaseFirestore.collection(collectionPath).doc(docId);
    try {
      doc.update({
        'fields': FieldValue.arrayUnion([
          ...[field]
        ]),
      });
      print('done');
    } catch (e) {
      print('Catched Error Message inside add Uni Method = ${e.toString()}');
    }
  }

  static Future addSpecialization(
      {required String collectionPath,
      required String docId,
      required List<Map> spec}) async {
    final doc = firebaseFirestore.collection(collectionPath).doc(docId);
    try {
      doc.set({
        'specializations': FieldValue.arrayUnion([...spec]),
      }, SetOptions(merge: true));
      print('done');
    } catch (e) {
      print('Catched Error Message inside add Uni Method = ${e.toString()}');
    }
  }

  static Future deleteSpecialization(
      {required String collectionPath,
      required String docId,
      required List<Map> spec}) async {
    final doc = firebaseFirestore.collection(collectionPath).doc(docId);
    try {
      doc.set({
        'specializations': FieldValue.arrayRemove([...spec]),
      }, SetOptions(merge: true));
      print('done');
    } catch (e) {
      print('Catched Error Message inside add Uni Method = ${e.toString()}');
    }
  }

  static Future<bool> addUniversity2(
      {required String collectionPath, required University uniData}) async {
    final doc = await firebaseFirestore
        .collection(collectionPath)
        .doc(uniData.name)
        .get();
    try {
      if (doc.exists) {
        return false;
      } else {
        await firebaseFirestore
            .collection(collectionPath)
            .doc(uniData.name)
            .set(uniData.toMap2(), SetOptions(merge: true));
        return true;
      }
    } catch (e) {
      print('Catched Error Message inside add Uni Method = ${e.toString()}');
      return false;
    }
  }

  Stream<UserData?> getUserDoc({String? userId}) {
    return firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map(_userDataFromFirestore);
  }

  static Future bulkUploadFromExcelToFireStore(
      {required String fileName,
      required String sheetName,
      required String collectionName}) async {
    final rowsData = await Utils.readExcelFileData(
        excelFilePath: fileName, sheetName: sheetName);
    print('========= ${rowsData.length} ');
    try {
      rowsData.removeAt(0);

      print(rowsData.length);

      for (var row in rowsData) {
        firebaseFirestore.collection(collectionName).doc(row[0]).set({
          'name': row[0],
          'fields': FieldValue.arrayUnion([
            ...[row[5]]
          ]),
          'specializations': FieldValue.arrayUnion([
            ...[
              {
                'field': row[5],
                'spec': row[4],
                'lang': row[1],
                'location': row[3],
                'fees': row[2],
                'note': row[6] ?? '',
              }
            ]
          ]),
        }, SetOptions(merge: true));
      }
    } catch (e) {
      print('Cached ERROR MESSAGE = = = = ${e.toString()}');
    }
    try {} catch (e) {
      print('Cached ERROR MESSAGE = = = = ${e.toString()}');
    }
  }

  static Stream<DocumentSnapshot> getUniData(
      {required String branch, required String uniName}) {
    return firebaseFirestore.collection(branch).doc(uniName).snapshots();
  }

  static Stream<QuerySnapshot> getData({required String collectionName}) {
    return firebaseFirestore.collection(collectionName).snapshots();
  }

  UserData? _userDataFromFirestore(DocumentSnapshot doc) {
    return UserData(
      id: _auth.currentUser!.uid,
      email: doc['email'],
      role: doc['role'],
      userName: doc['userName'],
    );
  }
}
