import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/services/firestore_services.dart';
import 'package:hdtc_project/widgets/admin_sidebar.dart';
import 'package:hdtc_project/widgets/back_Button.dart';

import '../constants/my_constants.dart';

class EditSpecScreen extends StatefulWidget {
  final dynamic spec;
  final String branch;
  final String uniName;

  const EditSpecScreen(
      {Key? key,
      required this.spec,
      required this.branch,
      required this.uniName})
      : super(key: key);
  @override
  State<EditSpecScreen> createState() => _EditSpecScreenState();
}

class _EditSpecScreenState extends State<EditSpecScreen> {
  late TextEditingController _feesController;
  late TextEditingController _fieldController;
  late TextEditingController _langController;
  late TextEditingController _noteController;
  late TextEditingController _specController;
  late TextEditingController _locationController;
  @override
  void initState() {
    super.initState();
    _feesController = TextEditingController(text: widget.spec['fees']);
    _fieldController = TextEditingController(text: widget.spec['field']);
    _langController = TextEditingController(text: widget.spec['lang']);
    _noteController = TextEditingController(text: widget.spec['note']);
    _specController = TextEditingController(text: widget.spec['spec']);
    _locationController = TextEditingController(text: widget.spec['location']);
  }

  @override
  void dispose() {
    _feesController.dispose();
    _fieldController.dispose();
    _langController.dispose();
    _noteController.dispose();
    _specController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            const AdminSideBar(currentIndex: 2),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: width * 0.4,
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      cursorHeight: 0,
                      cursorWidth: 0,
                      decoration: MyConstants.formTextFieldInputDecoration(
                          hintText: 'اسم الفرع'),
                      controller: _fieldController,
                    ),
                  ),
                  Container(
                    width: width * 0.4,
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      cursorHeight: 0,
                      cursorWidth: 0,
                      decoration: MyConstants.formTextFieldInputDecoration(
                          hintText: 'اسم التخصص'),
                      controller: _specController,
                    ),
                  ),
                  Container(
                    width: width * 0.4,
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      cursorHeight: 0,
                      cursorWidth: 0,
                      decoration: MyConstants.formTextFieldInputDecoration(
                          hintText: ' اللغة'),
                      controller: _langController,
                    ),
                  ),
                  Container(
                    width: width * 0.4,
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        cursorHeight: 0,
                        cursorWidth: 0,
                        decoration: MyConstants.formTextFieldInputDecoration(
                            hintText: 'المدينة'),
                        controller: _locationController),
                  ),
                  Container(
                    width: width * 0.4,
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      cursorHeight: 0,
                      cursorWidth: 0,
                      decoration: MyConstants.formTextFieldInputDecoration(
                          hintText: 'السعر'),
                      controller: _feesController,
                    ),
                  ),
                  Container(
                    width: width * 0.4,
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      cursorHeight: 0,
                      cursorWidth: 0,
                      decoration: MyConstants.formTextFieldInputDecoration(
                          hintText: 'الملاحظات'),
                      controller: _noteController,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final initialMap = {
                          'field': widget.spec['field'],
                          'lang': widget.spec['lang'],
                          'location': widget.spec['location'],
                          'spec': widget.spec['spec'],
                          'fees': widget.spec['fees'],
                          'note': widget.spec['note'],
                        };
                        final editedMap = {
                          'field': _fieldController.text.trim().toLowerCase(),
                          'lang': _langController.text.trim().toLowerCase(),
                          'location':
                              _locationController.text.trim().toLowerCase(),
                          'spec': _specController.text.trim().toLowerCase(),
                          'fees': _feesController.text.trim().toLowerCase(),
                          'note': _noteController.text.trim().toLowerCase(),
                        };
                        if (mapEquals(editedMap, initialMap)) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('لم يتم إجراء أي تعديل'),
                                    actions: [
                                      OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('موافق'))
                                    ],
                                  ));
                        } else {
                          try {
                            await FireStoreServices.deleteSpecialization(
                                collectionPath: widget.branch,
                                docId: widget.uniName,
                                spec: [initialMap]);
                            await FireStoreServices.addSpecialization(
                                collectionPath: widget.branch,
                                docId: widget.uniName,
                                spec: [editedMap]);
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text('تم التعديل بنجاح'),
                                      actions: [
                                        OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('موافق'))
                                      ],
                                    ));
                          } catch (e) {
                            print(e.toString());
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text(
                                          'حدث خطأ أثناء التعديل الرجاء المحاولة لاحقاً'),
                                      actions: [
                                        OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('موافق'))
                                      ],
                                    ));
                          }
                        }
                      },
                      child: const Text('تعديل المعلومات')),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red[800], onPrimary: Colors.white),
                      onPressed: () async {
                        try {
                          final initialMap = {
                            'field': widget.spec['field'],
                            'lang': widget.spec['lang'],
                            'location': widget.spec['location'],
                            'spec': widget.spec['spec'],
                            'fees': widget.spec['fees'],
                            'note': widget.spec['note'],
                          };
                          await FireStoreServices.deleteSpecialization(
                              collectionPath: widget.branch,
                              docId: widget.uniName,
                              spec: [initialMap]);
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('تم الحذف بنجاح'),
                                    actions: [
                                      OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('موافق'))
                                    ],
                                  ));
                        } catch (e) {
                          print(e.toString());

                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text(
                                        'حدث خطأ أثناء الحذف الرجاء المحاولة لاحقاً'),
                                    actions: [
                                      OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('موافق'))
                                    ],
                                  ));
                        }
                      },
                      child: const Text('حذف التخصص'))
                ],
              ),
            ),
            const MyBackButton(),
          ],
        ),
      ),
    );
  }
}
