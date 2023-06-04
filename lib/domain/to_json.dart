import 'dart:io';
import 'package:excel/excel.dart';

// 将一个目录下的 xlsx、csv 文件 转换为 json 文件，放到 outputDir 下
Future<bool> convert2JsonFile(String inputDir, String outputDir) async {
  var dirFs = Directory(inputDir);
  await for (var entity in dirFs.list(recursive: false, followLinks: false)) {
    if (await FileSystemEntity.isDirectory(entity.path)) {
      continue;
    }
    var ext = getFileExtension(entity.path);
    List<String> allowExtArr = ["xlsx", "csv"];
    if (!allowExtArr.contains(ext)) {
      continue;
    }
    print(entity.path);
    var excelObj = Excel.decodeBytes(File(entity.path).readAsBytesSync());
    var tables = excelObj.tables;
    tables.forEach((tableName, table) {});
    var tableNames = tables.keys.toList();
    for (var i = 0; i < tableNames.length; i++) {
      var table = tables[tableNames[i]];
      print(tableNames[i]);
      var dataList = getOneTableData(tableNames[i], table);
      print(dataList);
      break;
    }
    break;

    // var sheet = excelObj.tables['Sheet1'];

    // List<Map<String, dynamic>> jsonData = [];

    // for (var row in sheet!.rows) {
    //   Map<String, dynamic> rowData = {};
    //   for (var cell in row) {
    //     var columnName = cell!.value;
    //     var value = cell.value;
    //     rowData[columnName] = value;
    //   }
    //   jsonData.add(rowData);
    // }
  }
  return true;
}

String getFileExtension(String filePath) {
  var fileName = filePath.split('/').last; // 获取文件名
  var parts = fileName.split('.'); // 分割文件名和后缀
  if (parts.length > 1) {
    return parts.last; // 返回最后一个元素作为后缀
  }
  return '';
}

List<String> getOneTableHeaders(String tableName, Sheet? sheet) {
  List<String> headers = [];
  if (sheet == null) {
    return headers;
  }
  for (var i = 0; i < sheet.maxRows; i++) {
    var row = sheet.row(i);
    if (i == 0) {
      for (var colNum = 0; colNum < sheet.maxCols; colNum++) {
        Data? cell = row[colNum];
        if (cell == null) {
          headers.add("");
        } else {
          headers.add(cell.value.toString());
        }
      }
    }
  }

  return headers;
}

List<Map<String, dynamic>>? getOneTableData(String tableName, Sheet? sheet) {
  List<Map<String, dynamic>> dataList = [];
  if (sheet == null) {
    return dataList;
  }

  List<String> headers = getOneTableHeaders(tableName, sheet);
  for (var i = 0; i < sheet.maxRows; i++) {
    Map<String, dynamic> rowData = {};
    if (i == 0) {
      continue;
    }

    var row = sheet.row(i);
    for (var colNum = 0; colNum < sheet.maxCols; colNum++) {
      Data? cell = row[colNum];
      String tmpKey = headers[colNum].toString();
      if (cell == null) {
        rowData[tmpKey] = "";
      } else {
        rowData[tmpKey] = cell.value.toString();
      }
    }
    dataList.add(rowData);
  }
  return dataList;
}
