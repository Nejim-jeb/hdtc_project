import 'package:flutter/material.dart';
import 'package:hdtc_project/constants/my_constants.dart';
import 'package:hdtc_project/screens/edit_spec_screen.dart';
import 'package:hdtc_project/utils.dart';

class SpecificationsWidget extends StatefulWidget {
  final Map spec;
  final String branch;
  final String uniName;

  const SpecificationsWidget(
      {Key? key,
      required this.spec,
      required this.branch,
      required this.uniName})
      : super(key: key);

  @override
  State<SpecificationsWidget> createState() => _SpecificationsWidgetState();
}

class _SpecificationsWidgetState extends State<SpecificationsWidget> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => EditSpecScreen(
                    spec: widget.spec,
                    branch: widget.branch,
                    uniName: widget.uniName))));
      },
      child: Container(
        decoration: BoxDecoration(
          color: MyConstants.primaryColor,
          border: Border.all(color: MyConstants.appGrey, width: 3),
          borderRadius: BorderRadius.circular(12),
        ),
        // margin: const EdgeInsets.symmetric(horizontal: 15),
        width: width * 0.26,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    Utils.capitalizeFirstOfEachWord(widget.spec['field']),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Icon(
                    Icons.menu_book_rounded,
                    color: MyConstants.secondaryColor,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    Utils.capitalizeFirstOfEachWord(widget.spec['spec']),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Icon(
                    Icons.school_outlined,
                    color: MyConstants.secondaryColor,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    Utils.capitalizeFirstOfEachWord(widget.spec['lang']),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Icon(
                    Icons.language_rounded,
                    color: MyConstants.secondaryColor,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    Utils.capitalizeFirstOfEachWord(widget.spec['location']),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: MyConstants.secondaryColor,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    Utils.capitalizeFirstOfEachWord(widget.spec['fees']),
                    textDirection: TextDirection.ltr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Icon(
                    Icons.attach_money_outlined,
                    color: MyConstants.secondaryColor,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    widget.spec['note'] == ''
                        ? 'No Notes Added'
                        : Utils.capitalizeFirstOfEachWord(widget.spec['note']),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Icon(
                    Icons.notes_rounded,
                    color: MyConstants.secondaryColor,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
