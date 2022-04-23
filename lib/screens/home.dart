import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/constants/my_constants.dart';
import 'package:hdtc_project/services/auth_services.dart';

import '../services/pdf_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  String? selectedUni;
  String? selectedSpec;
  String? selectedlang;
  String? selectedField;

  List<String>? testList = [];

  String? cost;
  final GlobalKey _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    print('initState Fired');
  }

  String test =
      'Medipol University-English-5,000\$-ISTANBUL,TURKEY-Civil Engineering-Engineering and Natural Sciences';

  String test2 = '          Medipol University                ';

  @override
  Widget build(BuildContext context) {
    List<String> newTest = test.trim().split('-');
    // newTest.join();
    print(newTest);
    print(test2.trim().length);

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return ListView(
          // shrinkWrap: true,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width * 0.5,
                    child: DropdownButtonFormField<String>(
                        hint: const Text('Select University'),
                        value: selectedUni,
                        items: testList
                            ?.map((e) => DropdownMenuItem<String>(
                                child: Text(e.toString())))
                            .toList(),
                        //  MyConstants.unisList
                        //   ..sort((a, b) {
                        //     return a.value!
                        //         .toLowerCase()
                        //         .compareTo(b.value!.toLowerCase());
                        //   }),
                        onChanged: (val) {
                          setState(() {
                            selectedUni = val;
                          });
                        }),
                  ),
                  SizedBox(
                    width: width * 0.5,
                    child: DropdownButtonFormField<String>(
                        hint: const Text('Select Field'),
                        value: selectedUni,
                        items: MyConstants.fieldList
                          ..sort((a, b) {
                            return a.value!
                                .toLowerCase()
                                .compareTo(b.value!.toLowerCase());
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
                        hint: const Text('Select Specialization'),
                        value: selectedSpec,
                        items: MyConstants.specsList
                          ..sort((a, b) {
                            return a.value!
                                .toLowerCase()
                                .compareTo(b.value!.toLowerCase());
                          }),
                        onChanged: (val) {
                          setState(() {
                            selectedSpec = val;
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
                                .compareTo(b.value!.toLowerCase());
                          }),
                        onChanged: (val) {
                          setState(() {
                            selectedlang = val;
                          });
                        }),
                  ),
                  SizedBox(
                    width: width * 0.5,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Fees',
                      ),
                      inputFormatters: const [
                        // TODO: inputFormatters to add $ sign to the end of the text
                        // TextInputFormatter.formatEditUpdate(oldValue, newValue){}
                      ],
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        cost = '$val USD';
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          await PdfAPI.generatePdf();
                        },
                        child: const Text('Download PDF')),
                  ),
                ],
              ),
            )
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(onPressed: () {
        try {
          _authService.signOut();
        } catch (e) {
          print('Catched Error = ${e.toString()}');
        }
      }),
    );
  }
}
