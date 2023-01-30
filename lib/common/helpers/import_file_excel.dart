import 'dart:io';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_base/common/utils/extensions/platform.dart';

class AppImportFile {
  static Future<List<List<String>>> convertFileExcelToList(Excel excel) async {
    final List<List<String>> result = [];

    for (var table in excel.tables.keys) {
      final List<List<Data?>> data = excel.tables[table]!.rows;
      for (int rowIndex = 0; rowIndex < data.length; rowIndex++) {
        List<String> rowData = [];
        for (int columnIndex = 0; columnIndex < data[rowIndex].length; columnIndex++) {
          rowData.add(data[rowIndex][columnIndex]?.value?.toString() ?? '');
        }
        result.add(rowData);
      }
    }
    return result;
  }

  /// pick file excel and handle it
  /// return list of list of string
  static Future<List<List<String>>> importFileExcel() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['xlsx'],
      type: FileType.custom,
    );
    if (result == null) {
      return [];
    }
    if (isWeb) {
      final Uint8List? bytes = result.files.first.bytes;
      if (bytes == null) {
        return [];
      }
      final Excel excel = Excel.decodeBytes(bytes);
      return convertFileExcelToList(excel);
    }
    try {
      final Uint8List bytes = File(result.files.single.path!).readAsBytesSync();
      final Excel excel = Excel.decodeBytes(bytes);
      return convertFileExcelToList(excel);
    } catch (e) {
      return [];
    }
  }
}
