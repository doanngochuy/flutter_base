import 'dart:developer';

import 'package:logger/logger.dart' as l;

class Logger {
  // Sample of abstract logging function
  static void write(String text) => log(text, name: "POS365.CASHIER");
}

final _logi = l.Logger(
  printer: l.PrettyPrinter(
    methodCount: 0,
    printEmojis: false,
    printTime: false,
    lineLength: 150,
    colors: true,
  ),
);

void debugConsoleLog(dynamic message) => _logi.d(message);

void infoLog(dynamic message) => _logi.w(message);
