import 'package:flutter/material.dart';
import 'package:hdtc_project/services/auth_services.dart';

import '../constants/my_constants.dart';
import 'change_password_dialog.dart';

class UserSideBar extends StatefulWidget {
  final int currentIndex;
  const UserSideBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<UserSideBar> createState() => _UserSideBarState();
}

class _UserSideBarState extends State<UserSideBar> {
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
                color: Colors.grey[300],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          child: Text(
                            'تغيير كلمة المرور',
                            style: TextStyle(
                                fontSize: 20, color: MyConstants.primaryColor),
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
                          },
                          child: Text(
                            'تسجيل خروج',
                            style: TextStyle(
                                fontSize: 20, color: MyConstants.primaryColor),
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
