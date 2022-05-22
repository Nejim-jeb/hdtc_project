import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:hdtc_project/utils.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
//import 'package:universal_html/html.dart' as html;
import 'dart:html' as html;

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
  static const phoneNumber = 'PHONE: 00905349204002';
  static const headerColor = '#ffd961';
  static const columnColor = '#ffe49a';
  static const footerText =
      'MOLLA GÜRANI MAH.Lütufpaşa SK. Hacıbey işhanı NO:54 K:5 Daire no: 39';

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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ]);

  static Future generateUniPdf(
      {required String uniName,
      required String branch,
      String? country,
      required List<Map> uniData,
      String? lang}) async {
    final font = await PdfGoogleFonts.sourceSans3SemiBold();
    List<List<String>> _filteredList2 = [];
    List<List<String>> _allData = [];
    if (lang != null && country == null) {
      for (var item in uniData) {
        if (item['lang'].toString().contains(lang) ||
            item['lang']
                .toString()
                .contains(Utils.capitalizeFirstOfEachWord(lang))) {
          List<String> rowData = [];
          rowData.add(Utils.capitalizeFirstOfEachWord(uniName));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['lang'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['fees'].toString()));
          rowData.add(
              Utils.capitalizeFirstOfEachWord(item['location'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['spec'].toString()));
          rowData
              .add(Utils.capitalizeFirstOfEachWord(item['field'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['note'].toString()));
          _filteredList2.add(rowData);
        }
      }
    } else if (lang == null && country != null) {
      for (var item in uniData) {
        if (item['location'].toString().contains(country) ||
            item['location']
                .toString()
                .contains(Utils.capitalizeFirstOfEachWord(country))) {
          List<String> rowData = [];
          rowData.add(Utils.capitalizeFirstOfEachWord(uniName));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['lang'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['fees'].toString()));
          rowData.add(
              Utils.capitalizeFirstOfEachWord(item['location'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['spec'].toString()));
          rowData
              .add(Utils.capitalizeFirstOfEachWord(item['field'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['note'].toString()));
          _filteredList2.add(rowData);
        }
      }
    } else if (lang != null && country != null) {
      for (var item in uniData) {
        if (item['location'].toString().contains(country) &&
            item['lang'].toString().contains(lang)) {
          List<String> rowData = [];
          rowData.add(Utils.capitalizeFirstOfEachWord(uniName));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['lang'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['fees'].toString()));
          rowData.add(
              Utils.capitalizeFirstOfEachWord(item['location'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['spec'].toString()));
          rowData
              .add(Utils.capitalizeFirstOfEachWord(item['field'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['note'].toString()));
          _filteredList2.add(rowData);
        }
      }
    } else {
      for (var item in uniData) {
        List<String> rowData = [];
        rowData.add(Utils.capitalizeFirstOfEachWord(uniName));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['lang'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['fees'].toString()));
        rowData
            .add(Utils.capitalizeFirstOfEachWord(item['location'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['spec'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['field'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['note'].toString()));
        _allData.add(rowData);
      }
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
            child:
                Center(child: Text(footerText, style: TextStyle(font: font)))),
        pageTheme: pageTheme,
        header: (context) =>
            buildHeader(phoneNumber: phoneNumber, imageJpj: imageJpj),
        build: (context) {
          var headerRow = TableRow(
              verticalAlignment: TableCellVerticalAlignment.full,
              children: headers
                  .map((cell) => Container(
                      padding: const EdgeInsets.all(8),
                      color: PdfColor.fromHex('#ffd961'),
                      child: Text(Utils.capitalizeFirstOfEachWord(cell),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 8.5, fontWeight: FontWeight.bold))))
                  .toList());
          return [
            Table(
              border: TableBorder.all(width: 1),
              defaultVerticalAlignment: TableCellVerticalAlignment.full,
              children: [
                headerRow,
                if (lang == null && country == null)
                  for (int i = 0; i < uniData.length; i++)
                    buildRow(
                        data: _allData,
                        index: i,
                        uniName: Utils.capitalizeFirstOfEachWord(uniName)),
                if (lang != null && country == null)
                  for (int i = 0; i < _filteredList2.length; i++)
                    buildFilteredRow(
                      uniName: Utils.capitalizeFirstOfEachWord(uniName),
                      data: _filteredList2,
                      index: i,
                      lang: lang,
                    ),
                if (lang == null && country != null)
                  for (int i = 0; i < _filteredList2.length; i++)
                    buildFilteredRow(
                      uniName: Utils.capitalizeFirstOfEachWord(uniName),
                      data: _filteredList2,
                      index: i,
                      lang: lang,
                    ),
                if (lang != null && country != null)
                  for (int i = 0; i < _filteredList2.length; i++)
                    buildFilteredRow(
                      uniName: Utils.capitalizeFirstOfEachWord(uniName),
                      data: _filteredList2,
                      index: i,
                      lang: lang,
                    )
              ],
              columnWidths: {
                0: const IntrinsicColumnWidth(flex: 1.5),
                2: const IntrinsicColumnWidth(flex: 1.0),
                3: const IntrinsicColumnWidth(flex: 1.3),
                4: const IntrinsicColumnWidth(flex: 1.9),
                5: const IntrinsicColumnWidth(flex: 1.8),
                6: const IntrinsicColumnWidth(flex: 1.5),
              },
            )
          ];
        },
      ),
    );
    List<int> bytes = await pdf.save();
    lang == null
        ? saveAndLaunchFileWeb(
            bytes, Utils.capitalizeFirstOfEachWord('$uniName $branch.pdf'))
        : saveAndLaunchFileWeb(bytes,
            Utils.capitalizeFirstOfEachWord('$uniName $branch $lang.pdf'));
  }

  static Future generateFieldPdf(
      {required List<Map> fieldData,
      String? country,
      String? lang,
      required String branch}) async {
    final font = await PdfGoogleFonts.sourceSans3SemiBold();
    List<List<String>> _filteredList2 = [];
    List<List<String>> _allData = [];
    if (lang != null && country == null) {
      for (var item in fieldData) {
        if (item['lang'].toString().contains(lang) ||
            item['lang']
                .toString()
                .contains(Utils.capitalizeFirstOfEachWord(lang))) {
          List<String> rowData = [];
          rowData.add(Utils.capitalizeFirstOfEachWord(item['name'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['lang'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['fees'].toString()));
          rowData.add(
              Utils.capitalizeFirstOfEachWord(item['location'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['spec'].toString()));
          rowData
              .add(Utils.capitalizeFirstOfEachWord(item['field'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['note'].toString()));
          _filteredList2.add(rowData);
        }
      }
    } else if (country != null && lang == null) {
      for (var item in fieldData) {
        if (item['location'].toString().contains(country) ||
            item['location']
                .toString()
                .contains(Utils.capitalizeFirstOfEachWord(country))) {
          List<String> rowData = [];
          rowData.add(Utils.capitalizeFirstOfEachWord(item['name']));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['lang'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['fees'].toString()));
          rowData.add(
              Utils.capitalizeFirstOfEachWord(item['location'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['spec'].toString()));
          rowData
              .add(Utils.capitalizeFirstOfEachWord(item['field'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['note'].toString()));
          _filteredList2.add(rowData);
        }
      }
    } else if (country != null && lang != null) {
      for (var item in fieldData) {
        if (item['location'].toString().contains(country) &&
            item['lang'].toString().contains(lang)) {
          print('------ WENT INSIDE IF STATEMENT ---------');
          List<String> rowData = [];
          rowData.add(Utils.capitalizeFirstOfEachWord(item['name']));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['lang'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['fees'].toString()));
          rowData.add(
              Utils.capitalizeFirstOfEachWord(item['location'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['spec'].toString()));
          rowData
              .add(Utils.capitalizeFirstOfEachWord(item['field'].toString()));
          rowData.add(Utils.capitalizeFirstOfEachWord(item['note'].toString()));
          _filteredList2.add(rowData);
        }
      }
    } else {
      for (var item in fieldData) {
        List<String> rowData = [];
        rowData.add(Utils.capitalizeFirstOfEachWord(item['name'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['lang'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['fees'].toString()));
        rowData
            .add(Utils.capitalizeFirstOfEachWord(item['location'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['spec'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['field'].toString()));
        rowData.add(Utils.capitalizeFirstOfEachWord(item['note'].toString()));
        _allData.add(rowData);
      }
    }

    // final fontFromAsset = await rootBundle.load('fonts/Cairo-Regular.ttf');
    // Font font = Font.ttf(fontFromAsset);
    final imageJpj =
        (await rootBundle.load('hdtc_logo2.jpg')).buffer.asUint8List();
    final imageBackground =
        (await rootBundle.load('hdtc_background.jpg')).buffer.asUint8List();

    final pageTheme = PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: const EdgeInsets.fromLTRB(50, 20, 50, 50),
        theme: ThemeData.withFont(base: font),
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
        footer: (context) {
          return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(
                  child: Text(footerText, style: TextStyle(font: font))));
        },
        pageTheme: pageTheme,
        header: (context) =>
            buildHeader(phoneNumber: phoneNumber, imageJpj: imageJpj),
        build: (context) {
          var headerRow = TableRow(
              verticalAlignment: TableCellVerticalAlignment.full,
              children: headers
                  .map((cell) => Container(
                      padding: const EdgeInsets.all(8),
                      color: PdfColor.fromHex('#ffd961'),
                      child: Text(Utils.capitalizeFirstOfEachWord(cell),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 8.5, fontWeight: FontWeight.bold))))
                  .toList());
          return [
            Table(
                border: TableBorder.all(width: 1),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: const IntrinsicColumnWidth(flex: 1.5),
                  2: const IntrinsicColumnWidth(flex: 1.0),
                  3: const IntrinsicColumnWidth(flex: 1.3),
                  4: const IntrinsicColumnWidth(flex: 1.9),
                  5: const IntrinsicColumnWidth(flex: 1.8),
                  6: const IntrinsicColumnWidth(flex: 1.5),
                },
                children: [
                  headerRow,
                  if (lang == null && country == null)
                    for (int i = 0; i < _allData.length; i++)
                      buildRow(
                          data: _allData,
                          index: i,
                          uniName: fieldData[i]['name']),
                  if (lang != null && country == null)
                    for (int i = 0; i < _filteredList2.length; i++)
                      buildFilteredFieldRow(
                        uniName: fieldData[i]['name'],
                        data: _filteredList2,
                        index: i,
                        lang: lang,
                      ),
                  if (lang == null && country != null)
                    for (int i = 0; i < _filteredList2.length; i++)
                      buildFilteredFieldRow(
                        uniName: fieldData[i]['name'],
                        data: _filteredList2,
                        index: i,
                        lang: lang,
                      ),
                  if (lang != null && country != null)
                    for (int i = 0; i < _filteredList2.length; i++)
                      buildFilteredFieldRow(
                        uniName: fieldData[i]['name'],
                        data: _filteredList2,
                        index: i,
                        lang: lang,
                      )
                ]

                //  lang == null
                //     ? [
                //         headerRow,
                //         for (int i = 0; i < _allData.length; i++)
                //           buildFieldRow(
                //             headers: headers,
                //             uniName: Utils.capitalizeFirstOfEachWord(
                //                 fieldData[i]['name']),
                //             data: _allData,
                //             index: i,
                //           )
                //       ]
                //     : [
                //         headerRow,
                //         for (int i = 0; i < _filteredList2.length; i++)
                //           buildFilteredFieldRow(
                //             uniName: Utils.capitalizeFirstOfEachWord(
                //                 _filteredList2[i][0]),
                //             data: _filteredList2,
                //             index: i,
                //             lang: lang,
                //           )
                //       ],
                )
          ];
        },
      ),
    );
    List<int> bytes = await pdf.save();
    lang == null
        ? saveAndLaunchFileWeb(
            bytes,
            Utils.capitalizeFirstOfEachWord(
                '$branch ${fieldData[0]['spec']}.pdf'))
        : saveAndLaunchFileWeb(
            bytes,
            Utils.capitalizeFirstOfEachWord(
                '$branch ${fieldData[0]['spec']} $lang.pdf'));
    _filteredList2 = [];
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

buildRow(
    {required List<List<String>> data,
    required String uniName,
    required int index}) {
  try {
    data.sort(
      (a, b) {
        return a[5].toLowerCase().compareTo(b[5].toLowerCase());
      },
    );
    return TableRow(
        children: data[index]
            .map((map) => Container(
                color: data[0][0] == uniName && map.contains(uniName)
                    ? PdfColor.fromHex('#ffe49a')
                    : null,
                padding: const EdgeInsets.all(8),
                //  color: PdfColors.red,
                child: Text(
                  map,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 9.5,
                      color: data[index].contains('closed') ||
                              data[index].contains('Closed')
                          ? PdfColors.red
                          : PdfColors.black),
                )))
            .toList());
  } catch (e) {
    print('Cached Error Message inside Table Row = $e');
  }
}

buildFilteredRow(
    {required List<List<String>> data,
    required String uniName,
    String? lang,
    required int index}) {
  try {
    return TableRow(
        verticalAlignment: TableCellVerticalAlignment.full,
        children: data[index]
            .map((map) => Container(
                  color: data[index][0] == uniName && map.contains(uniName)
                      ? PdfColor.fromHex('#ffe49a')
                      : null,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    map,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 9.5,
                        color: data[index].contains('closed') ||
                                data[index].contains('Closed')
                            ? PdfColors.red
                            : PdfColors.black),
                  ),
                ))
            .toList());
  } catch (e) {
    print('Cached Error Message inside filtered row = $e');
  }
}

buildFieldRow({
  required List<List<String>> data,
  required List<String> headers,
  required int index,
  required String uniName,
}) {
  try {
    return TableRow(
        verticalAlignment: TableCellVerticalAlignment.full,
        children: data[index]
            .map(
              (map) => Container(
                  padding: const EdgeInsets.all(8),
                  color: data[index][0] == uniName && map.contains(uniName)
                      ? PdfColor.fromHex('#ffe49a')
                      : null,
                  child: Text(map,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 9.5,
                          color: data[index].contains('closed') ||
                                  data[index].contains('Closed')
                              ? PdfColors.red
                              : PdfColors.black))),
            )
            .toList());
  } catch (e) {
    print('Cached Error Message = $e');
  }
}

buildFilteredFieldRow(
    {required List<List<String>> data,
    required String uniName,
    String? lang,
    required int index}) {
  try {
    return TableRow(
        verticalAlignment: TableCellVerticalAlignment.full,
        children: data[index]
            .map((map) => Container(
                color: data[index][0] == uniName && map.contains(uniName)
                    ? PdfColor.fromHex('#ffe49a')
                    : null,
                padding: const EdgeInsets.all(8),
                child: Text(map,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 9.5,
                        color: data[index].contains('closed') ||
                                data[index].contains('Closed')
                            ? PdfColors.red
                            : PdfColors.black))))
            .toList());
  } catch (e) {
    print('Cached Error Message in filtered row = $e');
  }
}
