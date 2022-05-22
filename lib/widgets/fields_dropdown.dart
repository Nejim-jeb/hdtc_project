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
  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //Fix
      width: 360,
      child: DropdownButtonFormField<String>(
          isExpanded: true, //Step 1
          iconDisabledColor: Colors.grey,
          iconEnabledColor: MyConstants.secondaryColor,
          //  key: _dropDownkey,
          decoration:
              MyConstants.formDropDownInputDecoration(hintText: 'اختر فرع'),
          value: widget.selectedField,
          items: widget.fieldsList!
              .map((e) => DropdownMenuItem(
                  value: e, child: Text(Utils.capitalizeFirstOfEachWord(e))))
              .toList()
            ..sort((a, b) {
              return a.value!.toLowerCase().compareTo(b.value!.toLowerCase());
            }),
          onChanged: widget.myOnChanged),
    );
  }
}
