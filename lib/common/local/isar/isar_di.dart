import 'package:get_it/get_it.dart';

class IsarDbDI {
  IsarDbDI._();

  static Future<void> init(GetIt injector) async {
    // injector.registerSingleton<AppLocalDatabase>(await IsarServiceImpl().init());
  }
}
