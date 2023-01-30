import 'package:get_it/get_it.dart';

import '../local.dart';
import 'isarx_service_impl.dart';
import 'repositories/repositories.dart';

class IsarXDbDI {
  IsarXDbDI._();

  static Future<void> init(GetIt injector) async {
    injector.registerSingleton<AppLocalDatabase>(await IsarXServiceImpl().init());
  }
}
