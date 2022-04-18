import 'package:flutter/material.dart';
import 'package:hdtc_project/models/user.dart';
import 'package:hdtc_project/screens/home.dart';
import 'package:hdtc_project/screens/sign_in.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AppUser?>(context);
    if (authProvider == null) {
      return const SiginScreen();
    } else {
      return HomeScreen();
    }
  }
}
