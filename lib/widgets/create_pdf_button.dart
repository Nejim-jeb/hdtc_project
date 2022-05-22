// import 'package:flutter/material.dart';
// import 'package:hdtc_project/services/pdf_services.dart';

// import '../utils.dart';

// class CreatePdfButton extends StatefulWidget {
//   CreatePdfButton(
//       {Key? key,
//       required this.fromUni,
//       required this.selectedUni,
//       required this.passedMapList,
//       required this.passedFieldData})
//       : super(key: key);
//   final bool fromUni;
//   final String? selectedUni;
//   final List<Map>? passedMapList;
//   List<Map> passedFieldData;

//   @override
//   State<CreatePdfButton> createState() => _CreatePdfButtonState();
// }

// class _CreatePdfButtonState extends State<CreatePdfButton> {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         onPressed: widget.fromUni == true
//             ? () async {
//                 Utils.showLoading(context, '');
//                 //TODO: FormValidation selectedUni Cannot be null must check before calling generateUniPDF
//                 await PdfAPI.generateUniPdf(
//                   branch: ,
//                   lang: ,
//                     uniName: widget.selectedUni!,
//                     uniData: widget.passedMapList!);
//                 Navigator.pop(context);
//                 // setState(() {
//                 //   selectedUni = null;
//                 //   passedMapList = null;
//                 // });
//               }
//             : (() async {
//                 print('button pressed');
//                 Utils.showLoading(context, '');
//                 //TODO: FormValidation selectedUni Cannot be null must check before calling generateUniPDF
//                 await PdfAPI.generateFieldPdf(
//                     fieldData: widget.passedFieldData);
//                 widget.passedFieldData = [];
//                 Navigator.pop(context);
//               }),
//         child: const Text('إنشاء الملف'));
//   }
// }
