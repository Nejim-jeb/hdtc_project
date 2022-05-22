import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hdtc_project/constants/my_constants.dart';
import 'package:hdtc_project/utils.dart';

class SearchableFieldsDropDown extends StatefulWidget {
  SearchableFieldsDropDown(
      {Key? key,
      required this.hintText,
      required this.myOnChanged,
      required this.selectedField,
      required this.fieldsList,
      required this.passedFieldData,
      required this.focusNode})
      : super(key: key);
  String? selectedField;
  String? hintText;
  final List<String>? fieldsList;
  final List<Map>? passedFieldData;
  ValueChanged myOnChanged;
  FocusNode? focusNode;

  @override
  State<SearchableFieldsDropDown> createState() =>
      _SearchableFieldsDropDownState();
}

class _SearchableFieldsDropDownState extends State<SearchableFieldsDropDown> {
  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: DropdownSearch<String>(
        dropdownButtonProps: const IconButtonProps(
            icon: Icon(Icons.arrow_drop_down_sharp), color: Colors.black),
        popupProps: PopupProps.menu(
          searchFieldProps: TextFieldProps(
            cursorColor: MyConstants.primaryColor,
            showCursor: false,
            decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(),
                hintText: 'Search',
                hintStyle: TextStyle(color: MyConstants.primaryColor)),
          ),
          itemBuilder: (context, item, isSelected) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                Utils.capitalizeFirstOfEachWord(item),
                style: TextStyle(
                  color: (item == widget.selectedField)
                      ? MyConstants.primaryColor
                      : Colors.black,
                  fontSize: 16,
                ),
              ),
            );
          },
          showSearchBox: true,
          showSelectedItems: true,
        ),
        items: widget.fieldsList!
          ..sort(
            (a, b) {
              return a.toLowerCase().compareTo(b.toLowerCase());
            },
          ),
        dropdownSearchDecoration:
            MyConstants.formDropDownInputDecoration(hintText: widget.hintText!),
        onChanged: widget.myOnChanged,
        selectedItem: widget.selectedField == null
            ? widget.selectedField
            : Utils.capitalizeFirstOfEachWord(widget.selectedField!),
      ),
    );
  }
}
