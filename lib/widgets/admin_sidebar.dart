import 'package:flutter/material.dart';
import 'package:hdtc_project/constants/my_constants.dart';
import 'package:hdtc_project/screens/home.dart';
import 'package:hdtc_project/screens/sign_up.dart';
import 'package:hdtc_project/screens/view_universities.dart';
import 'package:hdtc_project/services/auth_services.dart';

import 'change_password_dialog.dart';

class AdminSideBar extends StatefulWidget {
  final int currentIndex;
  final bool? firstRoute;
  const AdminSideBar(
      {Key? key, required this.currentIndex, required this.firstRoute})
      : super(key: key);

  @override
  State<AdminSideBar> createState() => _AdminSideBarState();
}

class _AdminSideBarState extends State<AdminSideBar> {
  late ScrollController myScrollController;
  @override
  void initState() {
    myScrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    myScrollController.dispose();
    super.dispose();
  }

  final AuthService _authService = AuthService();

  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }

  @override
  Widget build(BuildContext context) {
    //  Color(0x61000000)

    final height = MediaQuery.of(context).size.height;
    return isDesktop(context)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: height,
                color: Colors.grey[300],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: TextButton(
                          style: TextButton.styleFrom(),
                          onPressed: widget.currentIndex == 1
                              ? null
                              : () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: HomeScreen()))));
                                },
                          child: Text('?????????? PDF',
                              style: TextStyle(
                                fontWeight: widget.currentIndex == 1
                                    ? FontWeight.bold
                                    : null,
                                fontSize: 20,
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: TextButton(
                          onPressed: widget.currentIndex == 2 &&
                                  widget.firstRoute == true
                              ? null
                              : () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child:
                                                      UniversitiesScreen()))));
                                },
                          child: Text(
                            '?????? ????????????????',
                            style: TextStyle(
                                fontWeight: widget.currentIndex == 2
                                    ? FontWeight.bold
                                    : null,
                                fontSize: 20,
                                color: widget.firstRoute != null
                                    ? const Color(0x61000000)
                                    : MyConstants.primaryColor),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: TextButton(
                          onPressed: widget.currentIndex == 4
                              ? null
                              : () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: SignUpScreen()))));
                                },
                          child: Text(
                            '?????????? ???????????? ????????',
                            style: TextStyle(
                              fontWeight: widget.currentIndex == 4
                                  ? FontWeight.bold
                                  : null,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const ChangePasswordDialog();
                                });
                          },
                          child: Center(
                            child: Text(
                              '?????????? ???????? ????????????',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: MyConstants.primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: TextButton(
                          onPressed: () async {
                            await _authService.signOut(context);

                            setState(() {});
                          },
                          child: const Text(
                            '?????????? ????????',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
