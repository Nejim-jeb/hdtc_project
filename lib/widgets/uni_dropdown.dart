import 'package:flutter/material.dart';

import '../constants/my_constants.dart';
import '../utils.dart';

class UnisDropDownButton extends StatefulWidget {
  UnisDropDownButton(
      {Key? key,
      required this.myOnChanged,
      required this.unisList,
      required this.passedFieldData,
      required this.selectedUni,
      required this.focusNode})
      : super(key: key);
  String? selectedUni;
  final List<String>? unisList;
  final List<Map>? passedFieldData;
  FocusNode? focusNode;
  ValueChanged myOnChanged;
  @override
  State<UnisDropDownButton> createState() => _UnisDropDownButtonState();
}

class _UnisDropDownButtonState extends State<UnisDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: DropdownButtonFormField<dynamic>(
          //  key: _dropDownkey,
          decoration:
              MyConstants.formTextFieldInputDecoration(hintText: 'اختر جامعة'),
          //  hint: const Text('Select University'),
          value: widget.selectedUni,
          items: widget.unisList!
              .map((e) => DropdownMenuItem(
                  value: e, child: Text((Utils.capitalizeFirstOfEachWord(e)))))
              .toList()
            ..sort((a, b) {
              return a.value!.toLowerCase().compareTo(b.value!.toLowerCase());
            }),
          onChanged: widget.myOnChanged
          //  (val) {
          //   //   selectedField = null;
          //   // _fieldList.clear();
          //   FocusScope.of(context).requestFocus(widget.focusNode);
          //   setState(() {
          //     widget.selectedUni = val;
          //   });
          // },
          ),
    );
  }
}
