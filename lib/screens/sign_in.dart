import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/constants/my_constants.dart';
import 'package:hdtc_project/services/auth_services.dart';

class SiginScreen extends StatefulWidget {
  const SiginScreen({Key? key}) : super(key: key);

  @override
  State<SiginScreen> createState() => _SiginScreenState();
}

class _SiginScreenState extends State<SiginScreen> {
  bool isObsecure = true;
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
    print(defaultTargetPlatform);
    final width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: AutofillGroup(
          child: Center(
            child: SingleChildScrollView(
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
                        autofillHints: const [AutofillHints.email],
                        textDirection: TextDirection.ltr,
                        // keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
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
                        // onTap: () {
                        //   _passwordController.selection = TextSelection.collapsed(
                        //       offset: _passwordController.text.length);
                        // },
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.ltr,
                        autofillHints: const [AutofillHints.password],
                        obscureText: isObsecure,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 5),
                            prefixIcon: IconButton(
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
                            labelText: 'Password',
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
                        controller: _passwordController,
                      ),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                        onPressed: () async {
                          // TODO: Form if Valid
                          _authService.signInWithEmailAndPassword(
                              context: context,
                              email: _emailController.text.trim().toLowerCase(),
                              password: _passwordController.text
                                  .trim()
                                  .toLowerCase());
                        },
                        child: const Text('تسجيل الدخول')),
                  ],
                ),
              ),
            ),
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
