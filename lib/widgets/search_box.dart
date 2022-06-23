import 'package:flutter/material.dart';
import 'package:hdtc_project/constants/my_constants.dart';

class SearchWidget extends StatefulWidget {
  final String? text;
  final ValueChanged<String> onChanged;
  final String hintText;
  final TextEditingController? controllerTest;
  const SearchWidget(
      {Key? key,
      required this.text,
      required this.onChanged,
      required this.hintText,
      this.controllerTest})
      : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  // final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const styleActive = TextStyle(color: Colors.black);
    const styleHint = TextStyle(color: Colors.black54);
    final style = widget.text!.isEmpty ? styleHint : styleActive;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: 42,
        width: 400,
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(
              color: MyConstants.primaryColor,
            )),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          textAlign: TextAlign.start,
          controller: widget.controllerTest,
          decoration: InputDecoration(
            icon: Icon(
              Icons.search,
              color: MyConstants.primaryColor,
            ),
            suffixIcon: widget.text!.isNotEmpty
                ? GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: style.color,
                    ),
                    onTap: () {
                      widget.controllerTest!.clear();
                      widget.onChanged('');
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  )
                : null,
            hintText: 'Search',
            hintStyle: TextStyle(
              color: MyConstants.primaryColor,
              fontSize: 22,
            ),
            border: InputBorder.none,
          ),
          style: style,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
