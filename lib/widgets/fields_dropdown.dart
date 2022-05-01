import 'package:flutter/material.dart';

import '../constants/my_constants.dart';
import '../utils.dart';

class FieldsDropDownButton extends StatefulWidget {
  FieldsDropDownButton(
      {Key? key,
      required this.myOnChanged,
      required this.selectedField,
      required this.fieldsList,
      required this.passedFieldData,
      required this.focusNode})
      : super(key: key);
  String? selectedField;
  final List<String>? fieldsList;
  final List<Map>? passedFieldData;
  ValueChanged myOnChanged;
  FocusNode? focusNode;
  @override
  State<FieldsDropDownButton> createState() => _FieldsDropDownButtonState();
}

class _FieldsDropDownButtonState extends State<FieldsDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: DropdownButtonFormField<String>(
          //  key: _dropDownkey,
          decoration:
              MyConstants.formTextFieldInputDecoration(hintText: 'اختر فرع'),
          //   hint: const Text('Select Field'),
          value: widget.selectedField,
          items: widget.fieldsList!
              .map((e) => DropdownMenuItem(
                  value: e, child: Text(Utils.capitalizeFirstOfEachWord(e))))
              .toList()
            ..sort((a, b) {
              return a.value!.toLowerCase().compareTo(b.value!.toLowerCase());
            }),
          onChanged: widget.myOnChanged
          //  (val) {
          //   if (widget.passedFieldData!.isNotEmpty) {
          //     widget.passedFieldData!.clear();
          //   }
          //   if (val == null) {
          //     print('value on changed is null');
          //   }
          //   FocusScope.of(context).requestFocus(widget.focusNode);
          //   setState(() {
          //     widget.selectedField = val;
          //   });
          // }),
          ),
    );
  }
}
