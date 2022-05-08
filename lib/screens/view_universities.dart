import 'package:flutter/material.dart';
import 'package:hdtc_project/screens/branch_universities.dart';
import 'package:hdtc_project/widgets/admin_sidebar.dart';

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({Key? key}) : super(key: key);

  @override
  _UniversitiesScreenState createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Row(
        children: [
          const AdminSideBar(currentIndex: 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        fixedSize: Size(width * 0.30, 45)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BranchUniversitiesScreen(
                                      branch: 'bachelor')));
                    },
                    child: const Text('البكالوريوس')),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        fixedSize: Size(width * 0.30, 45)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BranchUniversitiesScreen(
                                      branch: 'master')));
                    },
                    child: const Text('الماستر')),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        fixedSize: Size(width * 0.30, 45)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BranchUniversitiesScreen(
                                      branch: 'phd')));
                    },
                    child: const Text('الدكتوراه')),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        fixedSize: Size(width * 0.30, 45)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BranchUniversitiesScreen(
                                      branch: 'vocational_schools')));
                    },
                    child: const Text('المدارس المهنية')),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
