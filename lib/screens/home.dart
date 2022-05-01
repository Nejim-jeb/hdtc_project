import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/services/auth_services.dart';
import 'package:hdtc_project/services/firestore_services.dart';
import 'package:hdtc_project/widgets/interest_radiobutton_widget.dart';
import '../services/pdf_services.dart';
import '../utils.dart';
import '../widgets/fields_dropdown.dart';
import '../widgets/my_checkbox.dart';
import '../widgets/sidebar.dart';
import '../widgets/uni_dropdown.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }

  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String? selectedRadio;
  String? selectedUni;
  String? selectedSpec;
  String? selectedlang;
  String? selectedField;
  String? currentUniSelection;
  bool fromUni = false;
  late FocusNode myFocusNode;
  late final List<String> _uniList;
  late final List<String> _fieldList;

  String? cost;
  String? currency;
  final GlobalKey _formkey = GlobalKey<FormState>();
  final GlobalKey _dropDownkey = GlobalKey();

  late Stream<QuerySnapshot> myStream;
  List<Map>? passedMapList;
  List<Map> passedFieldData = [];
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    selectedRadio = 'bachelor';
    _uniList = [];
    _fieldList = [];

    myStream = FireStoreServices.getData(collectionName: selectedRadio!);
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: StreamBuilder<QuerySnapshot>(
          stream: myStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // print('selected radios value - - - - = = = = $selectedRadio');
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Text('No Data'),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case ConnectionState.active:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('some error occured'),
                  );
                } else {
                  final documents = snapshot.data!.docs;
                  if (_uniList.isEmpty) {
                    for (var uni in documents) {
                      _uniList.add(uni.get('name'));
                    }
                  }

                  for (var doc in documents) {
                    if (doc.get('name') == selectedUni) {
                      passedMapList = List.from(doc.get('specializations'));
                    }
                  }

                  if (_fieldList.isEmpty) {
                    Set<String> fieldsSet = {};
                    for (var doc in documents) {
                      final fields = List<String>.from(doc.get('fields'));

                      fieldsSet.addAll(fields);
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
                    }
                  }
                  print('passedMapList before build = = = $passedFieldData');
                  print('selectedField = = = $selectedField');

                  return Scaffold(
                    body: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isDesktop(context)) const SideBar(currentIndex: 1),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InterestRadioButtons(
                                onChanged: ((value) {
                                  selectedRadio = value;
                                  setState(() {
                                    selectedUni = null;
                                    selectedField = null;
                                    selectedField = null;
                                    _uniList.clear();
                                    _fieldList.clear();
                                    myStream = FireStoreServices.getData(
                                        collectionName:
                                            value == 'vocational schools'
                                                ? value.replaceFirst(' ', '_')
                                                : value);
                                  });
                                }),
                                selectedChoice: selectedRadio!,
                              ),
                              MyCheckBox(
                                  myOnChanged: (value) {
                                    setState(() {
                                      if (selectedField != null) {
                                        selectedField = null;
                                      }
                                      if (selectedUni != null) {
                                        selectedUni = null;
                                      }
                                      if (_uniList.isNotEmpty) {
                                        selectedUni = null;
                                        _uniList.clear();
                                      }
                                      myStream = FireStoreServices.getData(
                                          collectionName: selectedRadio!);
                                      fromUni = value!;
                                    });
                                  },
                                  selectedUni: selectedUni,
                                  fromUni: fromUni,
                                  selectedField: selectedField,
                                  uniList: _uniList),
                              const SizedBox(
                                height: 20,
                              ),
                              fromUni == true
                                  ? UnisDropDownButton(
                                      myOnChanged: (value) {
                                        setState(() {
                                          selectedUni = value;
                                          print('pressed $selectedUni');
                                          print('data $passedMapList');
                                        });
                                      },
                                      focusNode: myFocusNode,
                                      passedFieldData: passedFieldData,
                                      selectedUni: selectedUni,
                                      unisList: _uniList,
                                    )
                                  : FieldsDropDownButton(
                                      myOnChanged: (value) {
                                        if (passedFieldData.isNotEmpty) {
                                          passedFieldData.clear();
                                        }
                                        setState(() {
                                          selectedField = value;
                                          FocusScope.of(context)
                                              .requestFocus(myFocusNode);
                                        });
                                      },
                                      focusNode: myFocusNode,
                                      fieldsList: _fieldList,
                                      passedFieldData: passedFieldData,
                                      selectedField: selectedField),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: ElevatedButton(
                                    onPressed: fromUni == true
                                        ? () async {
                                            Utils.showLoading(context);

                                            //TODO: FormValidation selectedUni Cannot be null must check before calling generateUniPDF
                                            await PdfAPI.generateUniPdf(
                                                uniName: selectedUni!,
                                                uniData: passedMapList!);
                                            Navigator.pop(context);
                                            // setState(() {
                                            //   selectedUni = null;
                                            //   passedMapList = null;
                                            // });
                                          }
                                        : (() async {
                                            print('button pressed');
                                            Utils.showLoading(context);
                                            //TODO: FormValidation selectedUni Cannot be null must check before calling generateUniPDF
                                            await PdfAPI.generateFieldPdf(
                                                fieldData: passedFieldData);
                                            passedFieldData = [];
                                            Navigator.pop(context);
                                          }),
                                    child: const Text('إنشاء الملف')),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    floatingActionButton: FloatingActionButton(onPressed: () {
                      print('selected radio = $selectedRadio');
                      print('_uniList is empty ? = ${_uniList.length}');
                      print('_FieldList is empty ? = ${_fieldList.length}');
                      print(
                          'passed Data to Field Func is  = ${passedFieldData.length}');
                      print(
                          'passed Data to Uni Func is  = ${passedMapList?.length}');
                    }),
                  );
                }

              default:
                return const Center(
                  child: Text('Something Went Wrong'),
                );
            }
          }),
    );
  }
}
