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
  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //Fix
      width: 360,
      child: DropdownButtonFormField<dynamic>(
          //  key: _dropDownkey,
          decoration:
              MyConstants.formDropDownInputDecoration(hintText: 'اختر جامعة'),
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

class LangDropDownButton extends StatefulWidget {
  LangDropDownButton(
      {Key? key,
      required this.myOnChanged,
      required this.focusNode,
      required this.selectedField,
      required this.selectedUni,
      required this.fromField,
      this.selectedLang})
      : super(key: key);
  String? selectedLang;
  final bool fromField;
  final String? selectedField;
  final String? selectedUni;
  FocusNode? focusNode;
  ValueChanged myOnChanged;
  @override
  State<LangDropDownButton> createState() => _LangDropDownButtonState();
}

class _LangDropDownButtonState extends State<LangDropDownButton> {
  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      //Fix
      width: 360,
      child: DropdownButtonFormField<dynamic>(
          disabledHint: widget.fromField == true
              ? const Text('اختر الفرع أولاً')
              : const Text('اختر الجامعة أولاً'),
          //  key: _dropDownkey,
          decoration: MyConstants.formDropDownInputDecoration(
              hintText: 'اختر لغة',
              isEnabled: widget.selectedUni != null
                  ? true
                  : false || widget.selectedField != null
                      ? true
                      : false),
          //  hint: const Text('Select University'),
          value: widget.selectedLang,
          items: MyConstants.langList
              .map((e) => DropdownMenuItem(
                  value: e, child: Text((Utils.capitalizeFirstOfEachWord(e)))))
              .toList()
            ..sort((a, b) {
              return a.value!.toLowerCase().compareTo(b.value!.toLowerCase());
            }),
          onChanged: widget.selectedField == null && widget.fromField == true ||
                  widget.selectedUni == null && widget.fromField == false
              ? null
              : widget.myOnChanged
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

class CountryDropDownButton extends StatefulWidget {
  CountryDropDownButton(
      {Key? key,
      required this.myOnChanged,
      required this.focusNode,
      required this.selectedField,
      required this.selectedUni,
      required this.fromField,
      this.selectedCountry})
      : super(key: key);
  String? selectedCountry;
  final bool fromField;
  final String? selectedField;
  final String? selectedUni;
  FocusNode? focusNode;
  ValueChanged myOnChanged;
  @override
  State<CountryDropDownButton> createState() => _CountryDropDownButtonState();
}

class _CountryDropDownButtonState extends State<CountryDropDownButton> {
  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      //Fix
      width: 360,
      child: DropdownButtonFormField<dynamic>(
          disabledHint: widget.fromField == true
              ? const Text('اختر الفرع أولاً')
              : const Text('اختر الجامعة أولاً'),
          //  key: _dropDownkey,
          decoration: MyConstants.formDropDownInputDecoration(
              hintText: 'اختر البلد',
              isEnabled: widget.selectedUni != null
                  ? true
                  : false || widget.selectedField != null
                      ? true
                      : false),
          //  hint: const Text('Select University'),
          value: widget.selectedCountry,
          items: MyConstants.countriesList
              .map((e) => DropdownMenuItem(
                  value: e, child: Text((Utils.capitalizeFirstOfEachWord(e)))))
              .toList()
            ..sort((a, b) {
              return a.value!.toLowerCase().compareTo(b.value!.toLowerCase());
            }),
          onChanged: widget.selectedField == null && widget.fromField == true ||
                  widget.selectedUni == null && widget.fromField == false
              ? null
              : widget.myOnChanged),
    );
  }
}
