import 'dart:io';
import 'dart:convert';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
//import 'package:universal_html/html.dart' as html;
import 'dart:html' as html;

class PdfAPI {
  Future<File> GeneratePdf() async {
    final pdf = Document();

    return File('path');
  }

  static Future GeneratePdfAsBytes() async {
    final pdf = Document();
    pdf.addPage(Page(
        build: (context) => Text('text test',
            style:
                TextStyle(fontSize: 25, color: PdfColor.fromHex('#000000')))));

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
