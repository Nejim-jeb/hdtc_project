import 'package:excel/excel.dart';
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
          rowData.add(cell?.value);
        }
        rowsData.add(rowData);

        print(rowsData);
        //  print(row.runtimeType);
      }
      return rowsData;
    } catch (e) {
      print('Catched Error String is = = = ' + e.toString());
      return [];
    }
  }
}
