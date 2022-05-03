import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hdtc_project/models/user.dart';
import 'package:hdtc_project/models/user_data.dart';
import 'package:hdtc_project/providers/auth_provider.dart';
import 'package:hdtc_project/services/firestore_services.dart';
import 'package:hdtc_project/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart'
    show LicenseEntryWithLineBreaks, LicenseRegistry, kIsWeb;

// TODO: Add Website Icon
// TODO: Manage Firebase Security Rules
// TODO: Disable Access by changing URL without Being Logged in
// TODO: show dialogs on signup etc...
// TODO: YENI YUZYIL ALPHABET PDF FIX
// TODO: Try tableRow instead of Table.oftextarray
// TODO: InputFormatter to auto add $ to the end of the text
// TODO: Pressing outside dropdown should unfocus
// TODO: AUTO FILL LOGIN TEXTFIELDS
// TODO: MATERIAL APP BUILDER => Directionality to all app and set custom navigator or router to App
// TODO: LOAD LOGO FROM FIRESTORGE PUBLIC NOW TRY TO MAKE PRIVATE WITH RULES
// Fix: Unfocus After field selection + signout (focus node used after dispose error)

void main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

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
    //  await Firebase.initializeApp();
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
          lazy: true,
          initialData: null,
        ),
        StreamProvider<UserData?>(
          catchError: (context, error) {
            print('ONCATCHERROR MESSAGE = $error');
            return null;
          },
          initialData: null,
          create: ((context) {
            return FireStoreServices()
                .getUserDoc(userId: FirebaseAuth.instance.currentUser!.uid);
          }),
        ),
      ],
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // navigatorKey: ,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),

          home: const Directionality(
              textDirection: TextDirection.rtl, child: Wrapper()),
        ),
      ),
    );
  }
}
