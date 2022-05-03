import 'package:flutter/material.dart';
import 'package:hdtc_project/constants/my_constants.dart';
import 'package:hdtc_project/services/auth_services.dart';
import 'package:hdtc_project/utils.dart';
import 'package:hdtc_project/widgets/admin_sidebar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final List<String> roles = ['admin', 'user'];
  late final rolesDropDownItems = roles
      .map((role) =>
          DropdownMenuItem(value: role, child: Text(Utils.capitalize(role))))
      .toList();
  late TextEditingController _passwordController;
  late TextEditingController _roleController;
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
    _roleController = TextEditingController();
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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Form(
          // TODO: Form Validation
          key: _formKey,
          child: Row(
            children: [
              const AdminSideBar(currentIndex: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * 0.5,
                      child: TextFormField(
                        cursorHeight: 0,
                        cursorWidth: 0,
                        decoration: MyConstants.formTextFieldInputDecoration(
                            hintText: 'الإيميل'),
                        controller: _emailController,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: width * 0.5,
                      child: TextFormField(
                        cursorHeight: 0,
                        cursorWidth: 0,
                        decoration: MyConstants.formTextFieldInputDecoration(
                            hintText: 'كلمة المرور'),
                        obscureText: true,
                        controller: _passwordController,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: width * 0.5,
                      child: TextFormField(
                        cursorHeight: 0,
                        cursorWidth: 0,
                        decoration: MyConstants.formTextFieldInputDecoration(
                            hintText: 'اسم المستخدم'),
                        controller: _userNameController,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: width * 0.5,
                      child: DropdownButtonFormField<String>(
                        decoration: MyConstants.formTextFieldInputDecoration(
                            hintText: 'الصلاحية'),
                        value: selectedRole,
                        items: rolesDropDownItems,
                        onChanged: (item) {
                          setState(() {
                            selectedRole = item;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(width * 0.20, 46)),
                        onPressed: () {
                          // TODO: Form if Valid
                          _authService.signUpWithEmailAndPassword(
                            email: _emailController.text.trim().toLowerCase(),
                            password:
                                _passwordController.text.trim().toLowerCase(),
                            userName:
                                _userNameController.text.trim().toLowerCase(),
                            role: selectedRole!.trim().toLowerCase(),
                          );
                        },
                        child: const Text('إنشاء حساب')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
