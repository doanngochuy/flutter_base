import 'package:EMO/common/local/local.dart';
import 'package:get_it/get_it.dart';

class LocalDbDI {
  LocalDbDI._();

  static Future<void> init(GetIt injector) async {
    injector.registerSingleton<PrefsService>(await PrefsServiceImpl().init());
    // await (kIsWeb ? IsarXDbDI.init(injector) : IsarDbDI.init(injector));
  }
}
