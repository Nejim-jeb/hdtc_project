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
  late TextEditingController _emailController;
  late TextEditingController _userNameController;
  String? selectedRole;
  bool isObsecure = true;
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Row(
            children: [
              const AdminSideBar(currentIndex: 4, firstRoute: null),
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
                        validator: validateEmail,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: width * 0.5,
                      child: TextFormField(
                        cursorHeight: 0,
                        cursorWidth: 0,
                        obscureText: isObsecure,
                        decoration: InputDecoration(
                            hintMaxLines: 2,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObsecure = !isObsecure;
                                  });
                                },
                                icon: !isObsecure
                                    ? Icon(
                                        Icons.visibility,
                                        color: MyConstants.primaryColor,
                                      )
                                    : Icon(
                                        Icons.visibility_off_outlined,
                                        color: MyConstants.secondaryColor,
                                      )),
                            labelText: 'كلمة المرور',
                            labelStyle: TextStyle(
                              color: MyConstants.primaryColor,
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade800),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade900))),

                        // decoration: MyConstants.formTextFieldInputDecoration(
                        //     hintText: 'كلمة المرور'),

                        controller: _passwordController,
                        validator: (val) =>
                            val!.length > 5 ? null : 'كلمة المرور غير صالحة',
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
                        validator: (val) =>
                            val == '' ? 'هذا الحقل مطلوب' : null,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: width * 0.5,
                      child: DropdownButtonFormField<String>(
                        validator: (val) =>
                            val == '' || val == null ? 'هذا الحقل مطلوب' : null,
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await _authService.signUpWithEmailAndPassword(
                              context: context,
                              email: _emailController.text.trim().toLowerCase(),
                              password:
                                  _passwordController.text.trim().toLowerCase(),
                              userName:
                                  _userNameController.text.trim().toLowerCase(),
                              role: selectedRole!.trim().toLowerCase(),
                            );
                            _formKey.currentState!.reset();
                          }
                          // TODO: Form if Valid
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

  String? validateEmail(String? value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value!)) {
      return 'إيميل غير صالح';
    } else {
      return null;
    }
  }
}
