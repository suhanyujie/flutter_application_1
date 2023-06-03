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
    if (allowExtArr.contains(ext)) {
      continue;
    }
    var excelObj = Excel.decodeBytes(File(entity.path).readAsBytesSync());
    var sheet = excelObj.tables['Sheet1'];

    List<Map<String, dynamic>> jsonData = [];
    for (var row in sheet!.rows) {
      Map<String, dynamic> rowData = {};
      for (var cell in row) {
        var columnName = cell!.value;
        var value = cell.value;
        rowData[columnName] = value;
      }
      jsonData.add(rowData);
    }

    print(entity.path);
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
