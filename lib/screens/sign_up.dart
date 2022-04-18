import 'package:flutter/material.dart';
import 'package:hdtc_project/services/auth_services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final List<String> roles = ['admin', 'user'];
  late final rolesDropDownItems = roles
      .map((role) =>
          DropdownMenuItem(value: role, child: Text(role.toUpperCase())))
      .toList();
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _userNameController;
  String? selectedRole;
  final AuthService _authService = AuthService();
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _userNameController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _userNameController,
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedRole,
                items: rolesDropDownItems,
                onChanged: (item) {
                  setState(() {
                    selectedRole = item;
                  });
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () {
                    // TODO: Form if Valid
                    _authService.signUpWithEmailAndPassword(
                      email: _emailController.text.trim().toLowerCase(),
                      password: _passwordController.text.trim().toLowerCase(),
                      userName: _userNameController.text.trim().toLowerCase(),
                      role: selectedRole!.trim().toLowerCase(),
                    );
                  },
                  child: const Text('إنشاء حساب')),
            ],
          ),
        ),
      ),
    );
  }
}