import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfTest extends StatefulWidget {
  const PdfTest({Key? key}) : super(key: key);

  @override
  State<PdfTest> createState() => _PdfTestState();
}

class _PdfTestState extends State<PdfTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
                child: const Text('text data'),
                onPressed: () async {
                  print('pressed');

                  try {
                    await generateUniPdf();
                  } catch (e) {
                    print('Error Message $e');
                  }
                }),
          )
        ],
      ),
    );
  }
}

Future generateUniPdf() async {
  List<Map<String, dynamic>> mapList = [
    {'name': 'Wleed', 'lang': 'arabic/English'},
    {'name': 'ahmet', 'lang': 'closed'},
    {'name': 'halit', 'lang': 'english/turkish'},
  ];

  List<List<String>> data = [];
  for (var item in mapList) {
    List<String> rowData = [];
    rowData.add(item['name']);
    rowData.add(item['lang']);
    data.add(rowData);
  }

  const pageTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
  );

  final pdf = pw.Document();
  pdf.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (context) => [
        pw.Table(border: pw.TableBorder.all(width: 2), children: [
          for (int i = 0; i < data.length; i++) buildRow(data: data[i])
        ])
      ],
    ),
  );
  List<int> bytes = await pdf.save();
  saveAndLaunchFileWeb(bytes, 'FileName.pdf');
}

buildRow({required List data, bool? isHeader}) {
  try {
    return pw.TableRow(
        children: data
            .map((map) => pw.Center(
                child: pw.Text(map,
                    style: pw.TextStyle(
                        color: data.contains('closed')
                            ? PdfColors.red
                            : PdfColors.blue))))
            .toList());
  } catch (e) {
    print('Cached Error Message = $e');
  }
}

Future<void> saveAndLaunchFileWeb(List<int> bytes, String fileName) async {
  html.AnchorElement(
      href:
          "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
    ..setAttribute("download", fileName)
    ..click();
}
