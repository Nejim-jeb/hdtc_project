import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/services/auth_services.dart';
import 'package:hdtc_project/services/firestore_services.dart';
import 'package:hdtc_project/utils.dart';
import '../constants/my_constants.dart';
import '../services/pdf_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  String? selectedUni;
  String? selectedSpec;
  String? selectedlang;
  String? selectedField;
  String? currentUniSelection;
  bool fromFileds = true;

  late final List<String> _uniList;
  late final List<String> _fieldList;

  String? cost;
  String? currency;
  final GlobalKey _formkey = GlobalKey<FormState>();
  late final Stream<QuerySnapshot> myStream;
  List<Map>? passedMapList;
  List<Map> passedFieldData = [];

  @override
  void initState() {
    super.initState();
    _uniList = [];
    _fieldList = [];
    myStream = FireStoreServices.getUni();
  }

  List<String>? functionTest({List<String>? fields}) {
    return fields;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
        stream: myStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final documents = snapshot.data!.docs;

            if (_uniList.isEmpty) {
              for (var uni in documents) {
                _uniList.add(uni.get('name'));
              }
            }

            for (var doc in documents) {
              if (doc.get('name') == selectedUni) {
                final res = List<String>.from(doc.get('fields'));
                passedMapList = List.from(doc.get('specializations'));

                // for (var item in res) {
                //   if (_fieldList.contains(item) == false) {
                //     _fieldList.add(item);
                //   }
                // }
              }
            }
            if (_fieldList.isEmpty) {
              Set<String> fieldsSet = {};
              for (var doc in documents) {
                final fields = List<String>.from(doc.get('fields'));
                fieldsSet.addAll(fields);
                // for (var element in fieldsSet) {
                //   _fieldList.add(element);
                // }
              }
              _fieldList.addAll(fieldsSet);
            }

            if (selectedField != null) {
              print('selected field = $selectedField');
              for (var doc in documents) {
                final fieldRes = List.of(doc['specializations']);

                for (var item in fieldRes) {
                  item['name'] = '${doc.get('name')}';
                }

                for (Map fieldData in fieldRes) {
                  if (fieldData.containsValue(selectedField)) {
                    passedFieldData.add(fieldData);
                  }
                }
                print(
                    'PASSED Field Rows Length= = = = = = =  ${passedFieldData.length}');
              }
            }

            return Scaffold(
              body: fromFileds == false
                  ? LayoutBuilder(builder: (context, constraints) {
                      return ListView(
                        children: <Widget>[
                          Container(
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //TODO: RadioButton instead of Checkbox to select fromFields value
                                Checkbox(
                                    activeColor: Colors.red,
                                    checkColor: Colors.blue,
                                    value: fromFileds,
                                    onChanged: (val) {
                                      setState(() {
                                        fromFileds = val!;
                                      });
                                    }),
                                Text(
                                    'From Field = false : ${fromFileds.toString()}'),
                                SizedBox(
                                  width: width * 0.5,
                                  child: DropdownButtonFormField<dynamic>(
                                      hint: const Text('Select University'),
                                      value: selectedUni,
                                      items: _uniList
                                          .map((e) => DropdownMenuItem(
                                              value: e, child: Text(e)))
                                          .toList()
                                        ..sort((a, b) {
                                          return a.value!
                                              .toLowerCase()
                                              .compareTo(
                                                  b.value!.toLowerCase());
                                        }),
                                      onChanged: (val) {
                                        //   selectedField = null;
                                        _fieldList.clear();
                                        setState(() {
                                          selectedUni = val;
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        final res =
                                            await Utils.readExcelFileData(
                                                sheetName: 'sheet1',
                                                excelFilePath:
                                                    'vocational_schools');

                                        print(res);
                                        //TODO: FormValidation selectedUni Cannot be null must check before calling generateUniPDF
                                        // await PdfAPI.generateUniPdf(
                                        //     uniName: selectedUni!,
                                        //     uniData: passedMapList!);
                                      },
                                      child: const Text('Download PDF')),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    })
                  : LayoutBuilder(builder: (context, constraints) {
                      return ListView(
                        children: <Widget>[
                          Container(
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                    activeColor: Colors.red,
                                    checkColor: Colors.blue,
                                    value: fromFileds,
                                    onChanged: (val) {
                                      setState(() {
                                        fromFileds = val!;
                                      });
                                    }),
                                Text(
                                    'From Field = true : ${fromFileds.toString()}'),
                                SizedBox(
                                  width: width * 0.5,
                                  child: DropdownButtonFormField<String>(
                                      hint: const Text('Select Field'),
                                      value: selectedField,
                                      items: _fieldList
                                          .map((e) => DropdownMenuItem(
                                              value: e, child: Text(e)))
                                          .toList()
                                        ..sort((a, b) {
                                          return a.value!
                                              .toLowerCase()
                                              .compareTo(
                                                  b.value!.toLowerCase());
                                        }),
                                      onChanged: (val) {
                                        setState(() {
                                          selectedField = val;
                                        });
                                      }),
                                ),
                                SizedBox(
                                  width: width * 0.5,
                                  child: DropdownButtonFormField<String>(
                                      hint: const Text('Select Language'),
                                      value: selectedlang,
                                      items: MyConstants.langList
                                        ..sort((a, b) {
                                          return a.value!
                                              .toLowerCase()
                                              .compareTo(
                                                  b.value!.toLowerCase());
                                        }),
                                      onChanged: (val) {
                                        setState(() {
                                          selectedlang = val;
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        print('button pressed');

                                        //TODO: FormValidation selectedUni Cannot be null must check before calling generateUniPDF
                                        await PdfAPI.generateFieldPdf(
                                            fieldData: passedFieldData);
                                      },
                                      child: const Text('Download Field PDF')),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }),
              floatingActionButton: FloatingActionButton(onPressed: () {
                setState(() {});
                // try {
                //   _authService.signOut();
                // } catch (e) {
                //   print('Catched Error = ${e.toString()}');
                // }
              }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
