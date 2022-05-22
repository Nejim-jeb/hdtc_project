import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/constants/my_constants.dart';
import 'package:hdtc_project/models/university.dart';
import 'package:hdtc_project/screens/university_screen.dart';
import 'package:hdtc_project/services/firestore_services.dart';

import '../utils.dart';

class UniversitiesScreenBody extends StatefulWidget {
  final List<QueryDocumentSnapshot<Object?>> data;
  final String branch;
  const UniversitiesScreenBody(
      {Key? key, required this.data, required this.branch})
      : super(key: key);
  @override
  _UniversitiesScreenBodyState createState() => _UniversitiesScreenBodyState();
}

class _UniversitiesScreenBodyState extends State<UniversitiesScreenBody> {
  late TextEditingController newUniController;
  @override
  void initState() {
    super.initState();
    newUniController = TextEditingController();
  }

  @override
  void dispose() {
    newUniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: SizedBox(
                  width: 800,
                  child: ListView.separated(
                    itemCount: widget.data.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UniversityScreen(
                                            branch: widget.branch,
                                            uniName: widget.data[index]
                                                .get('name'))));
                              },
                              child: FittedBox(
                                child: Text(
                                  Utils.capitalizeFirstOfEachWord(
                                      widget.data[index].get('name')),
                                  style: const TextStyle(fontSize: 25),
                                ),
                              )),
                          IconButton(
                              onPressed: () async {
                                await MyConstants.myAsyncShowDialog(
                                    context: context,
                                    title: 'هل أنت متأكد من حذف الجامعة',
                                    onPressed: () async {
                                      await FireStoreServices.deleteUni(
                                          collectionPath: widget.branch,
                                          uniName:
                                              widget.data[index].get('name'));
                                      Navigator.pop(context);
                                    });
                              },
                              icon: Icon(
                                Icons.delete_forever_outlined,
                                color: MyConstants.primaryColor,
                              ))
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(70, 70),
                        shape: const CircleBorder()),
                    onPressed: () async {
                      final _formkey = GlobalKey<FormState>();
                      showDialog(
                          context: context,
                          builder: (context) => Form(
                                key: _formkey,
                                child: AlertDialog(
                                  content: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      validator: (value) =>
                                          value == '' || value == null
                                              ? 'الرجاء تعبئة الحقل'
                                              : null,
                                      cursorHeight: 0,
                                      cursorWidth: 0,
                                      decoration: MyConstants
                                          .formTextFieldInputDecoration(
                                              hintText: 'اسم الجامعة'),
                                      controller: newUniController,
                                    ),
                                  ),
                                  actions: [
                                    OutlinedButton(
                                        onPressed: () async {
                                          if (_formkey.currentState!
                                              .validate()) {
                                            final uniData = University(
                                                fields: [],
                                                name: newUniController.text
                                                    .trim()
                                                    .toLowerCase(),
                                                specs: []);
                                            await FireStoreServices
                                                .addUniversity2(
                                                    collectionPath:
                                                        widget.branch,
                                                    uniData: uniData);
                                            newUniController.clear();
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text('إضافة')),
                                    OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('إلغاء الأمر')),
                                  ],
                                ),
                              ));
                    },
                    child: const Text(
                      'إضافة جامعة',
                      textAlign: TextAlign.center,
                    ))),
          ),
        ],
      ),
    );
  }
}
