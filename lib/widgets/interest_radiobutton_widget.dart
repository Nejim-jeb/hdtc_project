import 'package:flutter/material.dart';
import 'package:hdtc_project/utils.dart';

class InterestRadioButtons extends StatefulWidget {
  final ValueChanged onChanged;
  final String selectedChoice;

  const InterestRadioButtons(
      {Key? key, required this.onChanged, required this.selectedChoice})
      : super(key: key);
  @override
  State<InterestRadioButtons> createState() => _InterestRadioButtonsState();
}

class _InterestRadioButtonsState extends State<InterestRadioButtons> {
  final List<String> radioList = [
    'bachelor',
    'master',
    'phd',
    'vocational schools',
  ];

  String? selectionText;

  @override
  Widget build(BuildContext context) {
    // print('selectedChoice = ${widget.selectedChoice}');

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: radioList.map((value) {
          if (value == 'bachelor') {
            selectionText = 'بكالوريوس';
          } else if (value == 'master') {
            selectionText = 'ماستر';
          } else if (value == 'phd') {
            selectionText = 'دكتوراه';
          } else {
            selectionText = 'مدارس مهنية';
          }
          return SizedBox(
            width: 150,
            child: RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: Text(Utils.capitalizeFirstOfEachWord(selectionText!)),
                value: value,
                groupValue: widget.selectedChoice,
                onChanged: widget.onChanged),
          );
        }).toList());
  }
}
