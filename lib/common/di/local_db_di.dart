import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_base/common/local/local.dart';

class LocalDbDI {
  LocalDbDI._();

  static Future<void> init(GetIt injector) async {
    injector.registerSingleton<PrefsService>(await PrefsServiceImpl().init());
    // await (kIsWeb ? IsarXDbDI.init(injector) : IsarDbDI.init(injector));
  }
}
