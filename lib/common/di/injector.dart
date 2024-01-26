import 'package:get_it/get_it.dart';
import 'package:EMO/common/di/local_db_di.dart';
import 'package:EMO/common/di/route_di.dart';
import 'package:EMO/common/di/service_di.dart';
import 'package:EMO/common/di/store_di.dart';

class AppInjector {
  AppInjector._();

  static final injector = GetIt.instance;

  static Future<void> initializeDependencies() async {
    await LocalDbDI.init(injector);
    await ServiceDI.init(injector);
    await StoreDI.init(injector);
    await RouteDI.init(injector);
  }
}
