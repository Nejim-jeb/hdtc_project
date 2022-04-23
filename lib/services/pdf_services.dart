import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
//import 'package:universal_html/html.dart' as html;
import 'dart:html' as html;

import 'package:printing/printing.dart';

class PdfAPI {
  Future<File> generatePdfFromFile() async {
    final pdf = Document();
    pdf.addPage(Page(
        build: (context) => Text('text test',
            style:
                TextStyle(fontSize: 25, color: PdfColor.fromHex('#000000')))));
    return File(
        'path'); // should save and add the saved file path in order to work
  }

  static Future generatePdfAsBytes() async {
    final pdf = Document();
    pdf.addPage(Page(
        build: (context) => Text('text test',
            style:
                TextStyle(fontSize: 25, color: PdfColor.fromHex('#000000')))));

    List<int> bytes = await pdf.save();

    saveAndLaunchFileWeb(bytes, 'FileName.pdf');
    //  return File('path');
  }

  static Future generatePdf(
      //  {
      // required String uni,
      // required String spec,
      // required String lang,
      // required String field,
      // required String fees,
      // required String location,
      //}
      ) async {
    final font = await PdfGoogleFonts.sourceSans3SemiBold();
    // final fontArabic = await PdfGoogleFonts.notoKufiArabicExtraLight();

    final headers = [
      'UNIVERSITY',
      'LANGUAGE',
      'FEES',
      'LOCATION',
      'SPECIALIZATION',
      'FIELD',
      'NOTE'
    ];

    final data = [
      [
        'Istanbul Yeni Yüzyıl University',
        'Turkish',
        '9800\$',
        'Ankara\nTurkey',
        'Political Science And International Relations - Distance Learning',
        'Engineering and Natural Sciences',
        'Up to 25-50% discount'
      ],
      // [
      //   'Istanbul Yeni Yüzyıl University',
      //   'Turkish',
      //   '9800\$',
      //   'Ankara\nTurkey',
      //   'Political Science And International Relations - Distance Learning',
      //   'Engineering and Natural Sciences',
      // ],
      // [
      //   'Istanbul Yeni Yüzyıl University',
      //   'Turkish',
      //   '9800\$',
      //   'Ankara\nTurkey',
      //   'Political Science And International Relations - Distance Learning',
      //   'Engineering and Natural Sciences',
      // ],
      // [
      //   'Istanbul Yeni Yüzyıl University',
      //   'Turkish',
      //   '9800\$',
      //   'Ankara\nTurkey',
      //   'Political Science And International Relations - Distance Learning',
      //   'Engineering and Natural Sciences',
      // ],
      // [
      //   'Istanbul Yeni Yüzyıl University',
      //   'Turkish',
      //   '9800\$',
      //   'Ankara\nTurkey',
      //   'Political Science And International Relations - Distance Learning',
      //   'Engineering and Natural Sciences',
      // ],
      // [
      //   'Istanbul Yeni Yüzyıl University',
      //   'Turkish',
      //   '9800\$',
      //   'Ankara\nTurkey',
      //   'Political Science And International Relations - Distance Learning',
      //   'Engineering and Natural Sciences',
      // ],
      // [
      //   'Istanbul Yeni Yüzyıl University',
      //   'Turkish',
      //   '9800\$',
      //   'Ankara\nTurkey',
      //   'Political Science And International Relations - Distance Learning',
      //   'Engineering and Natural Sciences',
      // ],
      // [
      //   'Istanbul Yeni Yüzyıl University',
      //   'Turkish',
      //   '9800\$',
      //   'Ankara\nTurkey',
      //   'Political Science And International Relations - Distance Learning',
      //   'Engineering and Natural Sciences',
      // ],
    ];

    const phoneNumber = 'PHONE: 00905349206516';
    const headerColor = '#ffd961';
    const columnColor = '#ffe49a';

    const footerText =
        'Molla Gürani Mh. Millet Cd.Fildişi İş Merkezi No:90 kat1 işyeri No: 109/26, ISTANBUL-TURKEY, Fatih Fındıkzade';
    final imageJpj =
        (await rootBundle.load('hdtc_logo2.jpg')).buffer.asUint8List();
    final imageBackground =
        (await rootBundle.load('hdtc_background.jpg')).buffer.asUint8List();
    final pageTheme = PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: const EdgeInsets.fromLTRB(50, 20, 50, 50),
        theme: ThemeData(
          defaultTextStyle: TextStyle(font: font),
        ),
        buildBackground: (context) {
          return FullPage(
            ignoreMargins: true,
            child: Opacity(
                opacity: 0.1,
                child: Image(MemoryImage(imageBackground), fit: BoxFit.cover)),
          );
        });
    final pdf = Document();
    pdf.addPage(
      MultiPage(
        footer: (context) => Text(footerText, style: TextStyle(font: font)),
        pageTheme: pageTheme,
        header: (context) =>
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            width: 100,
            height: 100,
            child: Image(
              MemoryImage(imageJpj),
            ),
          ),
          Text(phoneNumber,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ]),
        build: (context) => [
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(height: 110),
            Table.fromTextArray(
                columnWidths: {
                  0: const IntrinsicColumnWidth(flex: 1.2),
                  // 1: const IntrinsicColumnWidth(flex: 1),
                  2: const IntrinsicColumnWidth(flex: 0.8),
                  // 3: const IntrinsicColumnWidth(flex: 1),
                  4: const IntrinsicColumnWidth(flex: 1.5),
                  5: const IntrinsicColumnWidth(flex: 1.1),
                  6: const IntrinsicColumnWidth(flex: 1),
                },
                cellHeight: 30,
                cellAlignment: Alignment.center,
                cellStyle: const TextStyle(fontSize: 10),
                cellDecoration: (index, data, rowNum) {
                  final defaultColor = const BoxDecoration().color;
                  if (index == 0) {
                    return BoxDecoration(color: PdfColor.fromHex(columnColor));
                  } else {
                    return BoxDecoration(color: defaultColor);
                  }
                },
                headerHeight: 1,
                headerAlignment: Alignment.center,
                headerDecoration:
                    BoxDecoration(color: PdfColor.fromHex(headerColor)),
                headerStyle:
                    TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                headers: headers,
                data: data),
          ]),
        ],
      ),
    );

    List<int> bytes = await pdf.save();

    saveAndLaunchFileWeb(bytes, 'FileName.pdf');
    //  return File('path');
  }

  Future openFile(File file) async {
    final filePath = file.path;

    await OpenFile.open(filePath);
  }

  static Future<void> saveAndLaunchFileWeb(
      List<int> bytes, String fileName) async {
    html.AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", fileName)
      ..click();
  }
}

class SaveServices {
  Future saveDocument({required String name, required Document pdf}) async {
    final bytes = await pdf.save();
  }
}
