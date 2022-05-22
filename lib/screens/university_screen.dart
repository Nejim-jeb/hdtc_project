import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/screens/university_specialization_screen.dart';
import 'package:hdtc_project/widgets/admin_sidebar.dart';
import '../constants/my_constants.dart';
import '../services/firestore_services.dart';
import '../utils.dart';
import '../widgets/back_Button.dart';

class UniversityScreen extends StatefulWidget {
  final String uniName;
  final String branch;
  const UniversityScreen(
      {Key? key, required this.uniName, required this.branch})
      : super(key: key);

  @override
  _UniversityScreenState createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {
  late NavigatorState _navigator;

  late TextEditingController newFieldController;
  late final myStream;

  @override
  void didChangeDependencies() {
    _navigator = Navigator.of(context);
    super.didChangeDependencies();
  }

  @override
  initState() {
    super.initState();
    newFieldController = TextEditingController();
    myStream = FirebaseFirestore.instance
        .collection(widget.branch)
        .doc(widget.uniName)
        .snapshots();
  }

  @override
  void dispose() {
    newFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 35),
      child: StreamBuilder<DocumentSnapshot>(
        stream: myStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List fields = List.of(snapshot.data!.get('fields'));
            if (fields.isEmpty) {
              return Scaffold(
                body: Center(
                  child: Column(
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
                            print('pressed open dialog');

                            final _formkey = GlobalKey<FormState>();
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Form(
                                          key: _formkey,
                                          child: TextFormField(
                                            validator: (value) =>
                                                value == null || value == ''
                                                    ? 'هذا الحقل مطلوب'
                                                    : null,
                                            cursorHeight: 0,
                                            cursorWidth: 0,
                                            decoration: MyConstants
                                                .formTextFieldInputDecoration(
                                                    hintText: 'اسم الفرع'),
                                            controller: newFieldController,
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        OutlinedButton(
                                            onPressed: () async {
                                              if (_formkey.currentState!
                                                  .validate()) {
                                                await FireStoreServices
                                                    .addField(
                                                  collectionPath: widget.branch,
                                                  docId: widget.uniName,
                                                  field: newFieldController.text
                                                      .trim()
                                                      .toLowerCase(),
                                                );
                                                newFieldController.clear();
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
                                    ));
                          },
                          child: const Text(
                            'إضافة فرع',
                            textAlign: TextAlign.center,
                          )),
                      const MyBackButton(),
                    ],
                  ),
                ),
              );
            } else {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Scaffold(
                  body: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AdminSideBar(currentIndex: 2, firstRoute: false),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  await MyConstants
                                                      .myAsyncShowDialog(
                                                          context: context,
                                                          title:
                                                              'هل أنت متأكد من حذف الفرع',
                                                          onPressed: () async {
                                                            try {
                                                              Navigator.pop(
                                                                  context);
                                                              await FireStoreServices.deleteField(
                                                                  fieldValue:
                                                                      fields[
                                                                          index],
                                                                  collectionPath:
                                                                      widget
                                                                          .branch,
                                                                  uniName: widget
                                                                      .uniName);
                                                            } catch (e) {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          AlertDialog(
                                                                            title:
                                                                                Text(e.toString()),
                                                                          ));
                                                            }
                                                          });
                                                },
                                                icon: Icon(
                                                  Icons.delete_forever_outlined,
                                                  color:
                                                      MyConstants.primaryColor,
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UniversitySpecializationScreen(
                                                                field: fields[
                                                                    index],
                                                                branch: widget
                                                                    .branch,
                                                                uniName: widget
                                                                    .uniName,
                                                              )));
                                                },
                                                child: FittedBox(
                                                  child: Text(
                                                    Utils
                                                        .capitalizeFirstOfEachWord(
                                                            fields[index]),
                                                    style: const TextStyle(
                                                        fontSize: 25),
                                                  ),
                                                )),
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          height: 15,
                                        );
                                      },
                                      itemCount: fields.length),
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
                                      onPressed: () {
                                        final _formkey = GlobalKey<FormState>();
                                        showDialog(
                                            context: context,
                                            builder: (context) => Form(
                                                  key: _formkey,
                                                  child: AlertDialog(
                                                    content: Directionality(
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      child: TextFormField(
                                                        validator: (value) =>
                                                            value == null ||
                                                                    value == ''
                                                                ? 'هذا الحقل مطلوب'
                                                                : null,
                                                        cursorHeight: 0,
                                                        cursorWidth: 0,
                                                        decoration: MyConstants
                                                            .formTextFieldInputDecoration(
                                                                hintText:
                                                                    'اسم الفرع'),
                                                        controller:
                                                            newFieldController,
                                                      ),
                                                    ),
                                                    actions: [
                                                      OutlinedButton(
                                                          onPressed: () async {
                                                            if (_formkey
                                                                .currentState!
                                                                .validate()) {
                                                              await FireStoreServices
                                                                  .addField(
                                                                collectionPath:
                                                                    widget
                                                                        .branch,
                                                                docId: widget
                                                                    .uniName,
                                                                field: newFieldController
                                                                    .text
                                                                    .trim()
                                                                    .toLowerCase(),
                                                              );
                                                              newFieldController
                                                                  .clear();
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                          },
                                                          child: const Text(
                                                              'إضافة')),
                                                      OutlinedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'إلغاء الأمر')),
                                                    ],
                                                  ),
                                                ));
                                      },
                                      child: const Text(
                                        'إضافة فرع',
                                        textAlign: TextAlign.center,
                                      ))),
                            ),
                          ],
                        ),
                      ),
                      const MyBackButton()
                    ],
                  ),
                ),
              );
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('went wrong please try again later'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
