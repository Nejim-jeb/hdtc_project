import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/services/firestore_services.dart';
import 'package:hdtc_project/widgets/admin_sidebar.dart';
import 'package:hdtc_project/widgets/specification_card.dart';

import '../constants/my_constants.dart';
import '../widgets/back_Button.dart';

class UniversitySpecializationScreen extends StatefulWidget {
  // final List<Map> spec;
  final String uniName;
  final String branch;
  final String field;
  const UniversitySpecializationScreen({
    Key? key,
    required this.field,
    required this.uniName,
    required this.branch,
  }) : super(key: key);

  @override
  _UniversitySpecializationScreenState createState() =>
      _UniversitySpecializationScreenState();
}

class _UniversitySpecializationScreenState
    extends State<UniversitySpecializationScreen> {
  late Stream<DocumentSnapshot> myStream;
  late GlobalKey<FormState> _formKey;

  late TextEditingController _feesController;
  late TextEditingController _fieldController;
  late TextEditingController _langController;
  late TextEditingController _noteController;
  late TextEditingController _specController;
  late TextEditingController _locationController;

  @override
  initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    myStream = FireStoreServices.getUniData(
        branch: widget.branch, uniName: widget.uniName);
    _feesController = TextEditingController();
    _fieldController = TextEditingController(text: widget.field);
    _langController = TextEditingController();
    _noteController = TextEditingController();
    _specController = TextEditingController();
    _locationController = TextEditingController();
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
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 35),
      child: Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            stream: myStream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case ConnectionState.active:
                  if (snapshot.hasError) {
                    return const Center(
                      child:
                          Text('Something Went Wrong please try again later'),
                    );
                  } else {
                    final data = snapshot.data;

                    final specs = List.of(data!['specializations'])
                        .where(
                            (element) => element.values.contains(widget.field))
                        .toList();

                    return specs.isEmpty
                        ? Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('???? ???????? ???? ?????????????? ??????????'),
                                const SizedBox(
                                  height: 25,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(70, 70),
                                        shape: const CircleBorder()),
                                    onPressed: () {
                                      buildSpecDialog(
                                          filed: widget.field,
                                          formKey: _formKey);
                                    },
                                    child: const FittedBox(
                                      child: Text(
                                        '??????????\n????????',
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                const MyBackButton(),
                              ],
                            ),
                          )
                        : Directionality(
                            textDirection: TextDirection.rtl,
                            child: Scaffold(
                              body: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AdminSideBar(
                                      currentIndex: 2, firstRoute: false),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Wrap(
                                                runSpacing: 10,
                                                spacing: 15,
                                                direction: Axis.horizontal,
                                                // crossAxisAlignment: WrapCrossAlignment.end,
                                                alignment: WrapAlignment.end,
                                                children: [
                                                  for (var i = 0;
                                                      i < specs.length;
                                                      i++)
                                                    SpecificationsWidget(
                                                        spec: specs[i],
                                                        branch: widget.branch,
                                                        uniName:
                                                            widget.uniName),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      fixedSize:
                                                          const Size(70, 70),
                                                      shape:
                                                          const CircleBorder()),
                                                  onPressed: () {
                                                    buildSpecDialog(
                                                        formKey: _formKey,
                                                        filed: widget.field);
                                                  },
                                                  child: const FittedBox(
                                                    child: Text(
                                                      '??????????\n????????',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Center(child: MyBackButton()),
                                ],
                              ),
                            ),
                          );
                  }
                default:
                  return const Center(
                    child: Text('Default Case'),
                  );
              }
            }),
      ),
    );
  }

  Future buildSpecDialog(
      {required String filed, required GlobalKey<FormState> formKey}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Directionality(
                textDirection: TextDirection.rtl,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) => value == '' || value == null
                              ? '???????????? ?????????? ??????????'
                              : null,
                          enabled: false,
                          cursorHeight: 0,
                          cursorWidth: 0,
                          decoration: MyConstants.formTextFieldInputDecoration(
                              hintText: '?????? ??????????'),
                          controller: _fieldController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) => value == '' || value == null
                              ? '???????????? ?????????? ??????????'
                              : null,
                          cursorHeight: 0,
                          cursorWidth: 0,
                          decoration: MyConstants.formTextFieldInputDecoration(
                              hintText: '?????? ????????????'),
                          controller: _specController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) => value == '' || value == null
                              ? '???????????? ?????????? ??????????'
                              : null,
                          cursorHeight: 0,
                          cursorWidth: 0,
                          decoration: MyConstants.formTextFieldInputDecoration(
                              hintText: ' ??????????'),
                          controller: _langController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            validator: (value) => value == '' || value == null
                                ? '???????????? ?????????? ??????????'
                                : null,
                            cursorHeight: 0,
                            cursorWidth: 0,
                            decoration:
                                MyConstants.formTextFieldInputDecoration(
                                    hintText: '??????????????'),
                            controller: _locationController),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) => value == '' || value == null
                              ? '???????????? ?????????? ??????????'
                              : null,
                          cursorHeight: 0,
                          cursorWidth: 0,
                          decoration: MyConstants.formTextFieldInputDecoration(
                              hintText: '??????????'),
                          controller: _feesController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          cursorHeight: 0,
                          cursorWidth: 0,
                          decoration: MyConstants.formTextFieldInputDecoration(
                              hintText: '??????????????????'),
                          controller: _noteController,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                OutlinedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          await FireStoreServices.addSpecialization(
                              collectionPath: widget.branch,
                              docId: widget.uniName,
                              spec: [
                                {
                                  'field': _fieldController.text
                                      .trim()
                                      .toLowerCase(),
                                  'spec':
                                      _specController.text.trim().toLowerCase(),
                                  'lang':
                                      _langController.text.trim().toLowerCase(),
                                  'location': _locationController.text
                                      .trim()
                                      .toLowerCase(),
                                  'fees':
                                      _feesController.text.trim().toLowerCase(),
                                  'note':
                                      _noteController.text.trim().toLowerCase(),
                                }
                              ]);

                          formKey.currentState!.reset();
                        } catch (e) {
                          print(
                              'CachedMessage inside Dialog = ${e.toString()}');
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('??????????')),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('?????????? ??????????')),
              ],
            ));
  }
}
