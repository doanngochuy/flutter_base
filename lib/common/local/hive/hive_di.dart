import 'package:get_it/get_it.dart';

import '../local.dart';
import 'hive_service_impl.dart';
import 'repositories/repositories.dart';

class HiveDbDI {
  HiveDbDI._();

  static Future<void> init(GetIt injector) async {
    injector.registerSingleton<AppLocalDatabase>(await HiveServiceImpl().init());
  }
}
