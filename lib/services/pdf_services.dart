import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:hdtc_project/utils.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
//import 'package:universal_html/html.dart' as html;
import 'dart:html' as html;

import 'package:printing/printing.dart';

class PdfAPI {
  static final headers = [
    'UNIVERSITY',
    'LANGUAGE',
    'FEES',
    'LOCATION',
    'SPECIALIZATION',
    'FIELD',
    'NOTE'
  ];
  static const phoneNumber = 'PHONE: 00905349206516';
  static const headerColor = '#ffd961';
  static const columnColor = '#ffe49a';
  static const footerText =
      'Molla Gürani Mh. Millet Cd.Fildişi İş Merkezi No:90 kat1 işyeri No: 109/26, ISTANBUL-TURKEY, Fatih Fındıkzade';

  static Widget buildHeader(
          {required String phoneNumber, required Uint8List imageJpj}) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          padding: const EdgeInsets.only(bottom: 25),
          width: 100,
          height: 100,
          child: Image(
            MemoryImage(imageJpj),
          ),
        ),
        Text(phoneNumber,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ]);

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

  static Future generateUniPdf(
      {required String uniName, required List<Map> uniData}) async {
    final font = await PdfGoogleFonts.sourceSans3SemiBold();
    // final fontArabic = await PdfGoogleFonts.notoKufiArabicExtraLight();

    List<List<dynamic>> uniMapToListofLists(
        {required String uniName, required List<Map> map}) {
      List<List<dynamic>> result = [];
      for (var item in map) {
        List<String> rowData = [];
        rowData.add(Utils.capitalizeFirstOfEachWord(uniName));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['lang'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['fees'].toString()));
        rowData
            .add(Utils.capitalizeFirstOfEachWord(item['location'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['spec'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['field'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['note'].toString()));
        result.add(rowData);
      }
      return result
        ..sort(
          (a, b) {
            return a[5].toLowerCase().compareTo(b[5].toLowerCase());
          },
        );
    }

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
        footer: (context) => Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(footerText, style: TextStyle(font: font))),
        pageTheme: pageTheme,
        header: (context) =>
            buildHeader(phoneNumber: phoneNumber, imageJpj: imageJpj),
        build: (context) => [
          Table.fromTextArray(
            columnWidths: {
              0: const IntrinsicColumnWidth(flex: 1.2),
              2: const IntrinsicColumnWidth(flex: 0.8),
              4: const IntrinsicColumnWidth(flex: 1.6),
              5: const IntrinsicColumnWidth(flex: 1.3),
              6: const IntrinsicColumnWidth(flex: 1),
            },
            cellHeight: 50,
            cellAlignment: Alignment.center,
            cellStyle: const TextStyle(
              fontSize: 9,
            ),
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
            headerStyle: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
            headers: headers,
            data: uniMapToListofLists(map: uniData, uniName: uniName),
          ),
        ],
      ),
    );
    List<int> bytes = await pdf.save();
    saveAndLaunchFileWeb(bytes, 'FileName.pdf');
  }

  static Future generateFieldPdf({required List<Map> fieldData}) async {
    final font = await PdfGoogleFonts.sourceSans3SemiBold();
    // final fontArabic = await PdfGoogleFonts.notoKufiArabicExtraLight();
    final imageJpj =
        (await rootBundle.load('hdtc_logo2.jpg')).buffer.asUint8List();
    final imageBackground =
        (await rootBundle.load('hdtc_background.jpg')).buffer.asUint8List();

    List<List<dynamic>> fieldMapToListofLists({required List<Map> map}) {
      List<List<dynamic>> result = [];
      for (var item in map) {
        List<String> rowData = [];
        rowData.add(Utils.capitalizeFirstOfEachWord(item['name'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['lang'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['fees'].toString()));
        rowData
            .add(Utils.capitalizeFirstOfEachWord(item['location'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['spec'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['field'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['note'].toString()));
        result.add(rowData);
      }
      return result
        ..sort(
          (a, b) {
            return a[5].toLowerCase().compareTo(b[5].toLowerCase());
          },
        );
    }

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
        footer: (context) => Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(footerText, style: TextStyle(font: font))),
        pageTheme: pageTheme,
        header: (context) =>
            buildHeader(phoneNumber: phoneNumber, imageJpj: imageJpj),
        build: (context) => [
          Table.fromTextArray(
            columnWidths: {
              0: const IntrinsicColumnWidth(flex: 1.2),
              2: const IntrinsicColumnWidth(flex: 0.8),
              4: const IntrinsicColumnWidth(flex: 1.6),
              5: const IntrinsicColumnWidth(flex: 1.3),
              6: const IntrinsicColumnWidth(flex: 1),
            },
            cellHeight: 50,
            cellAlignment: Alignment.center,
            cellStyle: const TextStyle(
              fontSize: 9,
            ),
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
            headerStyle: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
            headers: headers,
            data: fieldMapToListofLists(map: fieldData),
          ),
        ],
      ),
    );
    List<int> bytes = await pdf.save();
    saveAndLaunchFileWeb(bytes, 'FileName.pdf');
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
