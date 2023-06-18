import 'dart:io';
import 'package:excel/excel.dart';
import 'dart:convert';
import 'package:path/path.dart' as p;

// 将一个目录下的 xlsx、csv 文件 转换为 json 文件，放到 outputDir 下
Future<bool> convert2JsonFile(String inputDir, String outputDir) async {
  var dirFs = Directory(inputDir);
  await for (var entity in dirFs.list(recursive: false, followLinks: false)) {
    if (await FileSystemEntity.isDirectory(entity.path)) {
      continue;
    }
    var (_, ext) = getFileExtension(entity.path);
    var fileName = p.basenameWithoutExtension(entity.path);
    var targetFile = "$outputDir/$fileName.json";
    List<String> allowExtArr = ["xlsx", "csv"];
    if (!allowExtArr.contains(ext)) {
      continue;
    }
    // print(entity.path);
    var excelObj = Excel.decodeBytes(File(entity.path).readAsBytesSync());
    var tables = excelObj.tables;
    var tableNames = tables.keys.toList();
    var jsonStr = "";
    var enc = const JsonEncoder.withIndent("    ");
    for (var i = 0; i < tableNames.length;) {
      var table = tables[tableNames[i]];
      var dataList = getOneTableData(tableNames[i], table);
      jsonStr = enc.convert(dataList);
      break;
    }
    // 将转换后的字符串写入文件 todo
    await writeToFile(targetFile, jsonStr);
  }
  return true;
}

(String, String) getFileExtension(String filePath) {
  var fileName = filePath.split('/').last; // 获取文件名
  var parts = fileName.split('.'); // 分割文件名和后缀
  return (parts.first, parts.last);
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

writeToFile(String fName, String strData) async {
  // 检查文件是否存在
  File fh;
  if (!await File(fName).exists()) {
    // 如果不存在，则创建文件
    fh = await File(fName).create();
  } else {
    fh = File(fName);
  }
  // 写入数据 todo
  return fh.writeAsStringSync(strData, flush: true);
}
