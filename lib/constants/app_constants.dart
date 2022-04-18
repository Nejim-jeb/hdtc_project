import 'package:flutter/material.dart';

class AppConstants extends InheritedWidget {
  static AppConstants of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppConstants>()!;
  const AppConstants({required Widget child, Key? key})
      : super(key: key, child: child);

  final String usersCollectionPath = 'users';

  @override
  bool updateShouldNotify(AppConstants oldWidget) => false;
}
