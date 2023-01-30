import 'dart:io';

import 'package:excel/excel.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/common/utils/extensions/extensions.dart';

/// key is column key (key of value when model.toJson)
/// attention: key must be exactly the same as property name in model
/// name is real name of column
class FileExcelHeader {
  final String key;
  final String name;

  const FileExcelHeader({required this.key, required this.name});
}

class AppExportFile {
  /// function only test in android device, not test in ios because I write it in windows laptop
  static Future<File?> exportFileExcel(
    List<Map<String, dynamic>> dataExport, {
    String fileName = "export_file_excel",
    required List<FileExcelHeader> headers,
    bool showFileWhenDone = false,
    CellStyle? headerStyle,
    CellStyle? cellStyle,
  }) async {
    final Excel excel = Excel.createExcel();
    final Sheet sheet = excel.sheets[excel.getDefaultSheet() as String]!;

    /// set header excel
    for (int index = 0; index < headers.length; index++) {
      sheet
          .cell(
            CellIndex.indexByColumnRow(
              columnIndex: index,
              rowIndex: 0,
            ),
          )
          .value = headers[index].name;
      sheet
          .cell(
            CellIndex.indexByColumnRow(
              columnIndex: index,
              rowIndex: 0,
            ),
          )
          .cellStyle = headerStyle ??
          CellStyle(
            bold: true,
          );
    }

    /// set content excel
    for (int indexData = 1; indexData <= dataExport.length; indexData++) {
      for (int indexHeader = 0; indexHeader < headers.length; indexHeader++) {
        sheet
            .cell(
              CellIndex.indexByColumnRow(
                columnIndex: indexHeader,
                rowIndex: indexData,
              ),
            )
            .value = dataExport[indexData - 1][headers[indexHeader].key];
        sheet
            .cell(
              CellIndex.indexByColumnRow(
                columnIndex: indexHeader,
                rowIndex: indexData,
              ),
            )
            .cellStyle = cellStyle ??
            CellStyle(
              bold: false,
            );
      }
    }

    if (isWeb) {
      /// if is web, auto return null
      /// function: excel.save(fileName: fileName) auto download file so return null
      excel.save(fileName: '$fileName.xlsx');
      return null;
    }

    /// if is not web (Android or iOS)
    /// return File and use function: openFile(file) to open file, below
    var fileBytes = excel.save();
    var directory = await getApplicationDocumentsDirectory();

    final File file =
        File("${directory.path}/${fileName.toMobileFileName}.xlsx")
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes!);

    if (showFileWhenDone) {
      OpenResult result = await OpenFile.open(file.path);
      String message = result.message;
      switch (result.type) {
        case ResultType.done:
          CustomSnackBar.success(
            title: S.current.Thanh_cong,
            message: message,
          );
          break;
        case ResultType.fileNotFound:
          CustomSnackBar.error(
            title: S.current.That_bai,
            message: message,
          );
          break;
        case ResultType.noAppToOpen:
          CustomSnackBar.error(
            title: S.current.That_bai,
            message: message,
          );
          break;
        case ResultType.permissionDenied:
          CustomSnackBar.error(
            title: S.current.That_bai,
            message: message,
          );
          break;
        case ResultType.error:
          CustomSnackBar.error(
            title: S.current.That_bai,
            message: message,
          );
          break;
      }
    }

    return file;
  }
}
