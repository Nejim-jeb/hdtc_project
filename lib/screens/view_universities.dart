import 'package:flutter/material.dart';
import 'package:hdtc_project/constants/my_constants.dart';
import 'package:hdtc_project/screens/branch_universities.dart';
import 'package:hdtc_project/widgets/admin_sidebar.dart';
import 'package:hdtc_project/widgets/back_Button.dart';

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: MyConstants.primaryColor,
                        fixedSize: Size(width * 0.30, 45)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BranchUniversitiesScreen(
                                      branch: 'bachelor')));
                    },
                    child: Text(
                      'البكالوريوس',
                      style: TextStyle(
                          color: MyConstants.secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )),
                const SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: MyConstants.primaryColor,
                        fixedSize: Size(width * 0.30, 45)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BranchUniversitiesScreen(
                                      branch: 'master')));
                    },
                    child: Text(
                      'الماستر',
                      style: TextStyle(
                          color: MyConstants.secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )),
                const SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: MyConstants.primaryColor,
                        fixedSize: Size(width * 0.30, 45)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BranchUniversitiesScreen(
                                      branch: 'phd')));
                    },
                    child: Text(
                      'الدكتوراه',
                      style: TextStyle(
                          color: MyConstants.secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )),
                const SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: MyConstants.primaryColor,
                        fixedSize: Size(width * 0.30, 45)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BranchUniversitiesScreen(
                                      branch: 'vocational_schools')));
                    },
                    child: Text(
                      'المدارس المهنية',
                      style: TextStyle(
                          color: MyConstants.secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const MyBackButton()
        ],
      )),
    );
  }
}
