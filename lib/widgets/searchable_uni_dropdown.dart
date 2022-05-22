import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../constants/my_constants.dart';
import '../utils.dart';

class SearchableUniDropDown extends StatefulWidget {
  SearchableUniDropDown(
      {Key? key,
      required this.hintText,
      required this.myOnChanged,
      required this.unisList,
      required this.passedFieldData,
      required this.selectedUni,
      required this.focusNode})
      : super(key: key);

  String? selectedUni;
  String? hintText;
  final List<String>? unisList;
  final List<Map>? passedFieldData;
  FocusNode? focusNode;
  ValueChanged myOnChanged;

  @override
  State<SearchableUniDropDown> createState() => _SearchableUniDropDownState();
}

class _SearchableUniDropDownState extends State<SearchableUniDropDown> {
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
                  color: (item == widget.selectedUni)
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
        items: widget.unisList!
          ..sort((a, b) {
            return a.toLowerCase().compareTo(b.toLowerCase());
          }),
        dropdownSearchDecoration:
            MyConstants.formDropDownInputDecoration(hintText: widget.hintText!),
        onChanged: widget.myOnChanged,
        selectedItem: widget.selectedUni == null
            ? widget.selectedUni
            : Utils.capitalizeFirstOfEachWord(widget.selectedUni!),
      ),
    );
  }
}
