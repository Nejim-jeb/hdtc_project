import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/services/firestore_services.dart';

import '../widgets/admin_sidebar.dart';
import '../widgets/universities_screen_body.dart';

class BranchUniversitiesScreen extends StatefulWidget {
  final String branch;
  const BranchUniversitiesScreen({Key? key, required this.branch})
      : super(key: key);

  @override
  State<BranchUniversitiesScreen> createState() =>
      _BranchUniversitiesScreenState();
}

class _BranchUniversitiesScreenState extends State<BranchUniversitiesScreen> {
  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }

  late FireStoreServices fireStoreServices;
  late Stream<QuerySnapshot> myStream;
  List list = [];
  @override
  void initState() {
    super.initState();
    fireStoreServices = FireStoreServices();
    myStream = FireStoreServices.getData(
        collectionName: widget.branch); // selectedRadio!
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: myStream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('some error occured'),
                    );
                  } else {
                    final universities = snapshot.data!.docs;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AdminSideBar(currentIndex: 2),
                        UniversitiesScreenBody(
                            data: universities, branch: widget.branch)
                      ],
                    );
                  }

                default:
                  return Container(
                    child: const Center(
                      child: Text('Default Case'),
                    ),
                  );
              }
            }),
      ),
    );
  }
}
