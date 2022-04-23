import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hdtc_project/constants/my_constants.dart';
import 'package:hdtc_project/models/university.dart';

class FireStoreServices {
  static final firebaseFirestore = FirebaseFirestore.instance;

  static Future<void> addUniversity(
      {required String collectionPath, required University uniData}) async {
    firebaseFirestore
        .collection(collectionPath)
        .doc(uniData.name)
        .set(uniData.toMap(), SetOptions(merge: true));
  }

  static Stream<QuerySnapshot> getUni() {
    return firebaseFirestore
        .collection(MyConstants.firestoreUniCollectionPath)
        .snapshots();
  }
}
