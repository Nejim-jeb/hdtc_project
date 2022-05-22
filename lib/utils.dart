import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static Future<List<List<dynamic>>> readExcelFileData(
      {required String excelFilePath, required String sheetName}) async {
    try {
      List<List<dynamic>> rowsData = [];
      final bytes =
          (await rootBundle.load('$excelFilePath.xlsx')).buffer.asUint8List();
      final excelFile = Excel.decodeBytes(bytes);

      final selectedExcel = excelFile.sheets[sheetName];
      // final rowCount = selectedExcel!.rows;
      for (var row in selectedExcel!.rows) {
        List<dynamic> rowData = [];
        for (var cell in row) {
          rowData.add(cell?.value.toString().trim().toLowerCase());
        }
        rowsData.add(rowData);
      }
      return rowsData;
    } catch (e) {
      print('Catched Error String is = = = ' + e.toString());
      return [];
    }
  }

  static String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1);
  }

  static String capitalizeFirstOfEachWord(String string) {
    if (string.isEmpty) {
      return string;
    }
    String result = string.split(" ").map((str) => capitalize(str)).join(" ");
    return result;
  }

  static showLoading(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(text),
              content: const SizedBox(
                height: 50,
                child: Center(child: CircularProgressIndicator()),
              ),
            ));
  }
}
