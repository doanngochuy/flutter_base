import 'package:get_it/get_it.dart';

import '../local.dart';
import 'isar_service_impl.dart';
import 'repositories/repositories.dart';

class IsarDbDI {
  IsarDbDI._();

  static Future<void> init(GetIt injector) async {
    // injector.registerSingleton<AppLocalDatabase>(await IsarServiceImpl().init());
  }
}
