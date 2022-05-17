import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/constants/my_constants.dart';
import 'package:hdtc_project/models/user_data.dart';
import 'package:hdtc_project/services/auth_services.dart';
import 'package:hdtc_project/services/firestore_services.dart';
import 'package:hdtc_project/widgets/interest_radiobutton_widget.dart';
import 'package:hdtc_project/widgets/user_sidebar.dart';
import '../services/pdf_services.dart';
import '../widgets/fields_dropdown.dart';
import '../widgets/admin_sidebar.dart';
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
  late FocusNode? myFocusNode;
  late final List<String> _uniList;
  late final List<String> _fieldList;
  late FireStoreServices fireStoreServices;
  String? cost;
  String? currency;
  final GlobalKey _formkey = GlobalKey<FormState>();
  final GlobalKey _dropDownkey = GlobalKey();
  late Stream<QuerySnapshot> myStream;
  late Stream<UserData?> userStream;

  List<Map>? passedMapList;
  List<Map> passedFieldData = [];
  @override
  void initState() {
    super.initState();
    fireStoreServices = FireStoreServices();
    myFocusNode = FocusNode();
    selectedRadio = 'bachelor';
    _uniList = [];
    _fieldList = [];
    userStream = fireStoreServices.getUserDoc(
        userId: FirebaseAuth.instance.currentUser!.uid);
    myStream = FireStoreServices.getData(collectionName: selectedRadio!);
  }

  @override
  void dispose() {
    myFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: StreamBuilder<UserData?>(
          stream: userStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data;
              return StreamBuilder<QuerySnapshot>(
                  stream: myStream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                              passedMapList =
                                  List.from(doc.get('specializations'));
                            }
                          }

                          if (_fieldList.isEmpty) {
                            Set<String> fieldsSet = {};
                            for (var doc in documents) {
                              final fields =
                                  List<String>.from(doc.get('fields'));
                              fieldsSet.addAll(fields);
                            }
                            _fieldList.addAll(fieldsSet);
                          }
                          if (selectedField != null && selectedlang == null) {
                            for (var doc in documents) {
                              final fieldRes = List.of(doc['specializations']);
                              for (var item in fieldRes) {
                                item['name'] = '${doc.get('name')}';
                              }
                              for (Map fieldData in fieldRes) {
                                if (fieldData['field'] == selectedField) {
                                  passedFieldData.add(fieldData);
                                }
                              }
                            }
                          }
                          return Scaffold(
                            drawer: !isDesktop(context)
                                ? SizedBox(
                                    width: 200,
                                    child: Drawer(
                                      backgroundColor: Colors.grey,
                                      child: ListView(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                _authService.signOut(context);
                                              },
                                              child: const ListTile(
                                                leading: Icon(
                                                  Icons.logout_outlined,
                                                  color: Colors.white,
                                                ),
                                                title: Text(
                                                  'تسجيل الخروج',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  )
                                : null,
                            body: SingleChildScrollView(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  userData!.role == 'admin'
                                      ? const AdminSideBar(currentIndex: 1)
                                      : const UserSideBar(currentIndex: 1),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Material(
                                                color: fromUni == false
                                                    ? MyConstants.primaryColor
                                                    : MyConstants.appGrey,
                                                child: InkWell(
                                                  splashColor: Colors.grey[300],
                                                  hoverColor: MyConstants
                                                      .secondaryColor,
                                                  onTap: () {
                                                    if (fromUni != false) {
                                                      setState(() {
                                                        fromUni = false;
                                                        selectedField = null;
                                                        selectedUni = null;
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            left: BorderSide(
                                                                color:
                                                                    MyConstants
                                                                        .appGrey,
                                                                width: 1.3))),
                                                    // width: width * 0.3 + 100,
                                                    height: 50,
                                                    child: Center(
                                                      child: Text(
                                                        'وفقاً للفرع',
                                                        style: TextStyle(
                                                            color: fromUni ==
                                                                    true
                                                                ? Colors.white
                                                                    .withOpacity(
                                                                        0.5)
                                                                : Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Material(
                                                color: fromUni == true
                                                    ? MyConstants.primaryColor
                                                    : MyConstants.appGrey,
                                                child: InkWell(
                                                  splashColor: Colors.grey[300],
                                                  hoverColor: MyConstants
                                                      .secondaryColor,
                                                  onTap: () {
                                                    if (fromUni != true) {
                                                      setState(() {
                                                        fromUni = true;
                                                        selectedField = null;
                                                        selectedUni = null;
                                                      });
                                                    }
                                                  },
                                                  child: SizedBox(
                                                    width: width * 0.3 + 100,
                                                    height: 50,
                                                    child: Center(
                                                      child: Text(
                                                        'وفقاً للجامعة',
                                                        style: TextStyle(
                                                            color: fromUni ==
                                                                    false
                                                                ? Colors.white
                                                                    .withOpacity(
                                                                        0.5)
                                                                : Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InterestRadioButtons(
                                            onChanged: ((value) {
                                              selectedRadio = value;
                                              setState(() {
                                                selectedUni = null;
                                                selectedField = null;
                                                selectedlang = null;
                                                _uniList.clear();
                                                _fieldList.clear();
                                                myStream =
                                                    FireStoreServices.getData(
                                                        collectionName: value ==
                                                                'vocational schools'
                                                            ? value
                                                                .replaceFirst(
                                                                    ' ', '_')
                                                            : value);
                                              });
                                            }),
                                            selectedChoice: selectedRadio!,
                                          ),
                                        ),
                                        // MyCheckBox(
                                        //     myOnChanged: (value) {
                                        //       setState(() {
                                        //         if (selectedField != null) {
                                        //           selectedField = null;
                                        //         }
                                        //         if (selectedlang != null) {
                                        //           selectedlang = null;
                                        //         }
                                        //         if (selectedUni != null) {
                                        //           selectedUni = null;
                                        //         }
                                        //         if (_uniList.isNotEmpty) {
                                        //           selectedUni = null;
                                        //           _uniList.clear();
                                        //         }
                                        //         myStream = FireStoreServices.getData(
                                        //             collectionName:
                                        //                 selectedRadio! ==
                                        //                         'vocational schools'
                                        //                     ? selectedRadio!
                                        //                         .replaceFirst(
                                        //                             ' ', '_')
                                        //                     : selectedRadio!);
                                        //         fromUni = value!;
                                        //       });
                                        //     },
                                        //     selectedUni: selectedUni,
                                        //     fromUni: fromUni,
                                        //     selectedField: selectedField,
                                        //     uniList: _uniList),

                                        fromUni == true
                                            ? Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: UnisDropDownButton(
                                                      myOnChanged: (value) {
                                                        setState(() {
                                                          selectedUni = value;
                                                          selectedlang = null;
                                                        });
                                                      },
                                                      focusNode: myFocusNode,
                                                      passedFieldData:
                                                          passedFieldData,
                                                      selectedUni: selectedUni,
                                                      unisList: _uniList,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: LangDropDownButton(
                                                      fromField: false,
                                                      selectedField:
                                                          selectedField,
                                                      selectedUni: selectedUni,
                                                      selectedLang:
                                                          selectedlang,
                                                      focusNode: myFocusNode,
                                                      myOnChanged: (val) {
                                                        setState(() {
                                                          selectedlang = val;
                                                        });
                                                      },
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: FieldsDropDownButton(
                                                        myOnChanged: (value) {
                                                          if (passedFieldData
                                                              .isNotEmpty) {
                                                            passedFieldData
                                                                .clear();
                                                          }
                                                          setState(() {
                                                            selectedField =
                                                                value;
                                                            selectedlang = null;

                                                            // FocusScope.of(context)
                                                            //     .requestFocus(myFocusNode);
                                                          });
                                                        },
                                                        focusNode: myFocusNode,
                                                        fieldsList: _fieldList,
                                                        passedFieldData:
                                                            passedFieldData,
                                                        selectedField:
                                                            selectedField),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: LangDropDownButton(
                                                      fromField: true,
                                                      selectedField:
                                                          selectedField,
                                                      selectedUni: selectedUni,
                                                      selectedLang:
                                                          selectedlang,
                                                      focusNode: myFocusNode,
                                                      myOnChanged: (val) {
                                                        setState(() {
                                                          selectedlang = val;
                                                        });
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                        const SizedBox(
                                          height: 20,
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                              style: Theme.of(context)
                                                  .elevatedButtonTheme
                                                  .style!
                                                  .copyWith(
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all<Size>(
                                                                const Size(
                                                                    95, 40)),
                                                    maximumSize:
                                                        MaterialStateProperty
                                                            .all<Size>(
                                                                const Size(
                                                                    95, 40)),
                                                    padding:
                                                        MaterialStateProperty
                                                            .all<EdgeInsets>(
                                                                EdgeInsets
                                                                    .zero),
                                                  ),
                                              onPressed: fromUni == true
                                                  ? () async {
                                                      //TODO: FormValidation selectedUni Cannot be null must check before calling generateUniPDF
                                                      try {
                                                        await PdfAPI.generateUniPdf(
                                                            branch:
                                                                selectedRadio!,
                                                            lang: selectedlang,
                                                            uniName:
                                                                selectedUni!,
                                                            uniData:
                                                                passedMapList!);
                                                        setState(() {
                                                          selectedUni = null;
                                                          selectedlang = null;
                                                        });
                                                      } catch (e) {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                          e.toString()),
                                                                    ));
                                                      }
                                                    }
                                                  : (() async {
                                                      try {
                                                        await PdfAPI.generateFieldPdf(
                                                            branch:
                                                                selectedRadio!,
                                                            lang: selectedlang,
                                                            fieldData:
                                                                passedFieldData);
                                                        setState(() {
                                                          passedFieldData = [];
                                                          selectedField = null;
                                                          selectedlang = null;
                                                        });
                                                      } catch (e) {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                          e.toString()),
                                                                    ));
                                                      }
                                                      //TODO: FormValidation selectedUni Cannot be null must check before calling generateUniPDF
                                                    }),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(3, 3, 8, 3),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: const [
                                                    Expanded(
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Icon(
                                                          Icons
                                                              .file_download_sharp,
                                                        ),
                                                      ),
                                                    ),
                                                    Text('إنشاء الملف'),
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      default:
                        return const Center(
                          child: Text('Something Went Wrong'),
                        );
                    }
                  });
            } else if (snapshot.hasError) {
              const Center(
                child: Text('Something Went Wrong Please try Again Later'),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
