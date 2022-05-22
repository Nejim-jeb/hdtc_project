import 'package:flutter/material.dart';
import 'package:hdtc_project/constants/my_constants.dart';
import 'package:hdtc_project/services/auth_services.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({Key? key}) : super(key: key);

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  bool isObsecure = true;

  String? newPassword;
  String? confirmedPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'تغيير كلمة المرور',
        textAlign: TextAlign.end,
      ),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  onChanged: (value) => setState(() {
                        newPassword = value.trim().toLowerCase();
                      }),
                  textAlign: TextAlign.left,
                  cursorHeight: 0,
                  cursorWidth: 0,
                  obscureText: isObsecure,
                  decoration: InputDecoration(
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
                      labelText: 'كلمة المرور الجديدة',
                      labelStyle: TextStyle(
                        color: MyConstants.primaryColor,
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade800),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade900))),
                  // decoration: MyConstants.formTextFieldInputDecoration(
                  //     hintText: 'كلمة المرور الجديدة'),

                  validator: (value) =>
                      value == null || value == '' || value.length < 6
                          ? 'كلمة المرور لا يمكن أن تكون فارغة أو أقل من 6 أحرف'
                          : null),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  onChanged: (value) => setState(() {
                        confirmedPassword = value.trim().toLowerCase();
                      }),
                  textAlign: TextAlign.left,
                  cursorHeight: 0,
                  cursorWidth: 0,
                  obscureText: isObsecure,
                  decoration: InputDecoration(
                      hintMaxLines: 2,
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
                      labelText: 'تأكيد كلمة المرور',
                      labelStyle: TextStyle(
                        color: MyConstants.primaryColor,
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade800),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade900))),
                  // decoration: MyConstants.formTextFieldInputDecoration(
                  //     hintText: 'تأكيد كلمة المرور'),
                  validator: (value) => newPassword == confirmedPassword
                      ? null
                      : 'كلمة المرور غير متطابقة'),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      actions: [
        OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('إلغاء الأمر')),
        OutlinedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await AuthService.changePassword(
                    newPassword: newPassword!, context: context);
              }
            },
            child: const Text('تغيير'))
      ],
    );
  }
}
