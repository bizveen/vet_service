
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';



Future<String> _getDirPath() async {
  final dir = await getApplicationDocumentsDirectory();
  return dir.path;
}

// This function is triggered when the "Read" button is pressed
Future<String> readData() async {
  final dirPath = await _getDirPath();
  final myFile = File('$dirPath/data.txt');
  final data = await myFile.readAsString(encoding: utf8);
  return data;
}

Future<void> writeData(String txt) async {
  final _dirPath = await _getDirPath();

  final _myFile = File('$_dirPath/data.txt');
  // If data.txt doesn't exist, it will be created automatically
print(_myFile.path);
  await _myFile.writeAsString(txt);

}