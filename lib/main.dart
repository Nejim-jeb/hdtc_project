import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hdtc_project/constants/my_constants.dart';
import 'package:hdtc_project/models/user.dart';
import 'package:hdtc_project/models/user_data.dart';
import 'package:hdtc_project/providers/auth_provider.dart';
import 'package:hdtc_project/services/firestore_services.dart';
import 'package:hdtc_project/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart'
    show LicenseEntryWithLineBreaks, LicenseRegistry, kIsWeb;

// Todo: € Problem in the data in FireStore (Training cost is ??€)
// Todo: Add Website Icon
// Todo: Manage Firebase Security Rules
// Todo: Disable Access by changing URL without Being Logged in
// Todo: show dialogs on signup etc...
// Todo: YENI YUZYIL ALPHABET PDF FIX
// Todo: Try tableRow instead of Table.oftextarray
// Todo: InputFormatter to auto add $ to the end of the text
// Todo: Pressing outside dropdown should unfocus
// Todo: AUTO FILL LOGIN TEXTFIELDS
// Todo: MATERIAL APP BUILDER => Directionality to all app and set custom navigator or router to App
// Todo: LOAD LOGO FROM FIRESTORGE PUBLIC NOW TRY TO MAKE PRIVATE WITH RULES
// FIX: Unfocus After field selection + signout (focus node used after dispose error)
//Todo: Add Form key with validation and clear form after submit and create PDF
// Todo: WHEN FILTER ON LANGUAGE CHECK 2 LANG ENGLISH/TURKISH - ENGLISH

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
            scaffoldBackgroundColor: Colors.grey[200],
            progressIndicatorTheme:
                ProgressIndicatorThemeData(color: MyConstants.primaryColor),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              primary: const Color(0xffc3b55f),
              onPrimary: const Color(0xff584f3f),
            )),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
              primary: const Color(0xffc3b55f),
            )),
            outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
              primary: const Color(0xffc3b55f),
            )),
            primarySwatch: Colors.amber,
          ),
          home: const Directionality(
              textDirection: TextDirection.rtl, child: Wrapper()),
        ),
      ),
    );
  }
}
