import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/models/user.dart';
import 'package:hdtc_project/providers/auth_provider.dart';
import 'package:hdtc_project/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// TODO: Add Website Icon
// TODO: Manage Firebase Security Rules
// TODO: Disable Access by changing URL without Being Logged in
// TODO: show dialogs on signup etc...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyASM0cq9ge7BjwbEvulaFUUw0UPG2Vx0iA",
            authDomain: "hdtc-project.firebaseapp.com",
            projectId: "hdtc-project",
            storageBucket: "hdtc-project.appspot.com",
            messagingSenderId: "556252644878",
            appId: "1:556252644878:web:a0b192831b9fb9ce625e5f"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const HdtcApp());
}

class HdtcApp extends StatelessWidget {
  const HdtcApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<AppUser?>(
          create: (context) => AuthProvider().getUser,
          initialData: AppUser(email: 'email', id: 'id', userName: 'name'),
          catchError: (context, object) {
            return null;
          },
        )
      ],
      child: MaterialApp(
        // navigatorKey: ,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Wrapper(),
      ),
    );
  }
}
