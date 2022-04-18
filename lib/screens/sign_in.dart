import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    print('Provided User sign in screen = ${userProvider?.email}');
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Form(
          // TODO: Form Validation
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () {
                    final auth = FirebaseAuth.instance;

                    print('current user email = ${auth.currentUser?.email}');

                    // TODO: Form if Valid
                    print(_emailController.text.trim().toLowerCase());
                    print(_passwordController.text.trim().toLowerCase());
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
    );
  }
}
