import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/constants/my_constants.dart';
import 'package:hdtc_project/models/university.dart';
import 'package:hdtc_project/screens/university_screen.dart';
import 'package:hdtc_project/services/firestore_services.dart';
import 'package:hdtc_project/widgets/search_box.dart';

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
  List<QueryDocumentSnapshot<Object?>>? filteredData;
  String? query = '';
  TextEditingController controller = TextEditingController();

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

  List<QueryDocumentSnapshot<Object?>> filteredList(
      {required List<QueryDocumentSnapshot<Object?>> data,
      required String query}) {
    // print('query = $query');
    // print('data length = ${data.length}');
    // print('filtered data length = ${data[0].get('name')}');
    // print('filtered data length = ${data[1].get('name')}');
    // print('=========================================');

    final res = data.where((element) {
      return element.get('name').contains(query.toLowerCase());
    }).toList();
    print('filtered data length = ${res.length}');

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSearch(),
          Expanded(
            child: Center(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: AllUniversities(
                  widget: widget,
                  data: query == null || query == ''
                      ? widget.data
                      : filteredList(data: widget.data, query: query!),
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

  Widget buildSearch() => SearchWidget(
        controllerTest: controller,
        text: query,
        hintText: 'Search',
        onChanged: (val) {
          setState(() {
            query = val;
          });
        },
      );
}

class AllUniversities extends StatelessWidget {
  const AllUniversities({
    Key? key,
    required this.widget,
    required this.data,
  }) : super(key: key);

  final UniversitiesScreenBody widget;
  final List<QueryDocumentSnapshot<Object?>>? data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      child: ListView.separated(
        itemCount: data!.length,
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
                                uniName: data![index].get('name'))));
                  },
                  child: FittedBox(
                    child: Text(
                      Utils.capitalizeFirstOfEachWord(data![index].get('name')),
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
                              uniName: data![index].get('name'));
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
    );
  }
}

class FilteredUniversities extends StatelessWidget {
  const FilteredUniversities({
    Key? key,
    required this.query,
    required this.widget,
    required this.data,
  }) : super(key: key);

  final String? query;
  final UniversitiesScreenBody widget;
  final List<QueryDocumentSnapshot<Object?>>? data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      child: ListView.separated(
        itemCount:
            query == null || query == '' ? widget.data.length : data!.length,
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
                                uniName: widget.data[index].get('name'))));
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
                              uniName: widget.data[index].get('name'));
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
    );
  }
}
