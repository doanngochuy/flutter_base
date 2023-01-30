import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

// read file json from assets
Future<dynamic> getDataFromJsonFile(String address) async {
  final String jsonString = await rootBundle.loadString(address);
  final data = await json.decode(jsonString);
  return data;
}

// read file json without declare path assets in pubspec.yaml
Future<dynamic> getDataFromJsonFileWithUnitTest(String address) async {
  final String jsonString = File(address).readAsStringSync();
  final data = await json.decode(jsonString);
  return data;
}
