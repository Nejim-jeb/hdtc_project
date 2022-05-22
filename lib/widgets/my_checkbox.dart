import 'package:flutter/material.dart';
import 'package:hdtc_project/constants/my_constants.dart';

class MyCheckBox extends StatefulWidget {
  bool fromUni;
  String? selectedField;
  String? selectedUni;
  List uniList;
  ValueChanged myOnChanged;

  MyCheckBox(
      {Key? key,
      required this.myOnChanged,
      required this.selectedUni,
      required this.fromUni,
      required this.selectedField,
      required this.uniList})
      : super(key: key);

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Checkbox(
            activeColor: MyConstants.primaryColor,
            checkColor: Colors.white,
            value: widget.fromUni,
            onChanged: widget.myOnChanged,

            //  (val) {
            //   setState(() {
            //     if (widget.selectedField != null) {
            //       widget.selectedField = null;
            //     }
            //     if (widget.selectedUni != null) {
            //       widget.selectedUni = null;
            //     }
            //     if (widget.uniList.isNotEmpty) {
            //       widget.selectedUni = null;
            //       widget.uniList.clear();
            //     }
            //     // myStream = FireStoreServices.getData(
            //     //     collectionName: selectedRadio!);
            //     widget.fromUni = val!;
            //   });
          ),
          widget.fromUni
              ? const Padding(
                  padding: EdgeInsetsDirectional.only(start: 16.0),
                  child: Text('وفقاً للجامعة'),
                )
              : const Padding(
                  padding: EdgeInsetsDirectional.only(start: 16.0),
                  child: Text('وفقاً للتخصص'),
                )
        ],
      ),
    );
  }
}
