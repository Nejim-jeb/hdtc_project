import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/constants/my_constants.dart';
import 'package:hdtc_project/models/user.dart';
import 'package:hdtc_project/services/auth_services.dart';
import 'package:provider/provider.dart';

class SiginScreen extends StatefulWidget {
  const SiginScreen({Key? key}) : super(key: key);

  @override
  State<SiginScreen> createState() => _SiginScreenState();
}

class _SiginScreenState extends State<SiginScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  final AuthService _authService = AuthService();
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    // _emailController.selection =
    //     TextSelection.collapsed(offset: _emailController.text.length);

    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AppUser?>(context);
    final width = MediaQuery.of(context).size.width;
    print('Provided User Role sign in screen = ${userProvider?.role}');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Form(
            // TODO: Form Validation
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: width * 0.5,
                  child: TextFormField(
                    cursorHeight: 0,
                    cursorWidth: 0,
                    textAlign: TextAlign.left,
                    decoration: MyConstants.formTextFieldInputDecoration(
                        hintText: 'البريد الإلكتروني'),
                    controller: _emailController,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: width * 0.5,
                  child: TextFormField(
                    onTap: () {
                      _passwordController.selection = TextSelection.collapsed(
                          offset: _passwordController.text.length);
                    },
                    textAlign: TextAlign.left,
                    cursorHeight: 0,
                    cursorWidth: 0,
                    obscureText: true,
                    decoration: MyConstants.formTextFieldInputDecoration(
                        hintText: 'كلمة المرور'),
                    controller: _passwordController,
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                    onPressed: () {
                      final auth = FirebaseAuth.instance;

                      // TODO: Form if Valid

                      _authService.signInWithEmailAndPassword(
                          email: _emailController.text.trim().toLowerCase(),
                          password:
                              _passwordController.text.trim().toLowerCase());
                    },
                    child: const Text('تسجيل الدخول')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
