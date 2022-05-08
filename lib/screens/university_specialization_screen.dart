import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/screens/edit_spec_screen.dart';
import 'package:hdtc_project/services/firestore_services.dart';
import 'package:hdtc_project/utils.dart';
import 'package:hdtc_project/widgets/admin_sidebar.dart';

import '../constants/my_constants.dart';

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
  late TextEditingController _feesController;
  late TextEditingController _fieldController;
  late TextEditingController _langController;
  late TextEditingController _noteController;
  late TextEditingController _specController;
  late TextEditingController _locationController;

  @override
  initState() {
    super.initState();
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
      child: StreamBuilder<DocumentSnapshot>(
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
                    child: Text('Something Went Wrong please try again later'),
                  );
                } else {
                  final data = snapshot.data;
                  final name = data!['name'];

                  final specs = List.of(data['specializations'])
                      .where((element) => element.values.contains(widget.field))
                      .toList();

                  return specs.isEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('لا يوجد أي معلومات للعرض'),
                            const SizedBox(
                              height: 25,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(70, 70),
                                    shape: const CircleBorder()),
                                onPressed: () {
                                  buildSpecDialog();
                                  //TODO: ADD FIELD TO CURRENT UNI
                                },
                                child: const FittedBox(
                                  child: Text(
                                    'إضافة\nتخصص',
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                          ],
                        )
                      : Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: [
                              const AdminSideBar(currentIndex: 2),
                              Expanded(
                                child: Column(
                                  children: [
                                    Flexible(
                                      child: GridView.builder(
                                        padding: const EdgeInsets.all(16),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 1,
                                                crossAxisCount:
                                                    isDesktop(context) ? 4 : 2,
                                                crossAxisSpacing: 25,
                                                mainAxisSpacing: 25),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            color: Colors.grey[300],
                                            padding: const EdgeInsets.all(16),
                                            child: DefaultTextStyle(
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              child: GridTile(
                                                footer: Center(
                                                  child: Material(
                                                    color: Colors.grey[300],
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          EditSpecScreen(
                                                                            uniName:
                                                                                widget.uniName,
                                                                            branch:
                                                                                widget.branch,
                                                                            spec:
                                                                                specs[index],
                                                                          )));
                                                        },
                                                        icon: const Icon(
                                                            Icons.edit)),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text.rich(
                                                        TextSpan(children: [
                                                          const TextSpan(
                                                            text: 'Spec: ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          TextSpan(
                                                            text: Utils
                                                                .capitalizeFirstOfEachWord(
                                                                    '${specs[index]['spec']}\n'),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                          const TextSpan(
                                                            text: 'Lang: ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          TextSpan(
                                                            text: Utils
                                                                .capitalizeFirstOfEachWord(
                                                                    '${specs[index]['lang']}\n'),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                          const TextSpan(
                                                            text: 'Fees: ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          TextSpan(
                                                            text: Utils
                                                                .capitalizeFirstOfEachWord(
                                                                    '${specs[index]['fees']}\n'),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                          const TextSpan(
                                                            text: 'Location: ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          TextSpan(
                                                            text: Utils
                                                                .capitalizeFirstOfEachWord(
                                                                    '${specs[index]['location']}\n'),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                          const TextSpan(
                                                            text: 'Note: ',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          TextSpan(
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                            text: Utils
                                                                .capitalizeFirstOfEachWord(
                                                                    '${specs[index]['note']}\n'),
                                                          ),
                                                        ]),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: specs.length,
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
                                                buildSpecDialog();
                                              },
                                              child: const FittedBox(
                                                child: Text(
                                                  'إضافة\nتخصص',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ))),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                }
              default:
                return const Center(
                  child: Text('Default Case'),
                );
            }

            final data = snapshot.data;
            return const Scaffold();
          }),
    );
  }

  Future buildSpecDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        enabled: false,
                        cursorHeight: 0,
                        cursorWidth: 0,
                        decoration: MyConstants.formTextFieldInputDecoration(
                            hintText: 'اسم الفرع'),
                        controller: _fieldController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        cursorHeight: 0,
                        cursorWidth: 0,
                        decoration: MyConstants.formTextFieldInputDecoration(
                            hintText: 'اسم التخصص'),
                        controller: _specController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        cursorHeight: 0,
                        cursorWidth: 0,
                        decoration: MyConstants.formTextFieldInputDecoration(
                            hintText: ' اللغة'),
                        controller: _langController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          cursorHeight: 0,
                          cursorWidth: 0,
                          decoration: MyConstants.formTextFieldInputDecoration(
                              hintText: 'المدينة'),
                          controller: _locationController),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        cursorHeight: 0,
                        cursorWidth: 0,
                        decoration: MyConstants.formTextFieldInputDecoration(
                            hintText: 'السعر'),
                        controller: _feesController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        cursorHeight: 0,
                        cursorWidth: 0,
                        decoration: MyConstants.formTextFieldInputDecoration(
                            hintText: 'الملاحظات'),
                        controller: _noteController,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                OutlinedButton(
                    onPressed: () async {
                      await FireStoreServices.addSpecialization(
                          collectionPath: widget.branch,
                          docId: widget.uniName,
                          spec: [
                            {
                              'field':
                                  _fieldController.text.trim().toLowerCase(),
                              'spec': _specController.text.trim().toLowerCase(),
                              'lang': _langController.text.trim().toLowerCase(),
                              'location':
                                  _locationController.text.trim().toLowerCase(),
                              'fees': _feesController.text.trim().toLowerCase(),
                              'note': _noteController.text.trim().toLowerCase(),
                            }
                          ]);
                      _fieldController.clear();
                      //TODO: Add From key with validation and clear form after submit
                      Navigator.pop(context);
                    },
                    child: const Text('إضافة')),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('إلغاء الأمر')),
              ],
            )); //TODO: ADD FIELD TO CURRENT UNI
  }
}
