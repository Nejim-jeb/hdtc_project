import 'package:flutter/material.dart';
import 'package:hdtc_project/screens/home.dart';
import 'package:hdtc_project/screens/sign_up.dart';
import 'package:hdtc_project/services/auth_services.dart';

class AdminSideBar extends StatefulWidget {
  final int currentIndex;
  const AdminSideBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<AdminSideBar> createState() => _AdminSideBarState();
}

class _AdminSideBarState extends State<AdminSideBar> {
  final AuthService _authService = AuthService();

  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return isDesktop(context)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: height,
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: TextButton(
                          onPressed: widget.currentIndex == 1
                              ? null
                              : () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          settings: const RouteSettings(
                                              name: 'HomeScreen'),
                                          builder: ((context) =>
                                              const Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: HomeScreen()))));
                                },
                          child: Text('إنشاء PDF',
                              style: TextStyle(
                                  fontWeight: widget.currentIndex == 1
                                      ? FontWeight.bold
                                      : null,
                                  fontSize: 20,
                                  color: Colors.black)),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: TextButton(
                          onPressed: null,
                          child: Text(
                            'عرض الجامعات',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: TextButton(
                          onPressed: null,
                          child: Text(
                            'عرض المستخدمين',
                            style: TextStyle(fontSize: 20, color: Colors.black),
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
                            'إنشاء مستخدم جديد',
                            style: TextStyle(
                                fontWeight: widget.currentIndex == 4
                                    ? FontWeight.bold
                                    : null,
                                fontSize: 20,
                                color: Colors.black),
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
                            print('sign our pressed');
                            await _authService.signOut(context);

                            setState(() {});
                          },
                          child: const Text(
                            'تسجيل الخروج',
                            style: TextStyle(fontSize: 20, color: Colors.black),
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