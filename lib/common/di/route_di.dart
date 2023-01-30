import 'package:get_it/get_it.dart';
import 'package:flutter_base/common/router/router.dart';

class RouteDI {
  RouteDI._();

  static Future<void> init(GetIt injector) async {
    injector.registerSingleton<AppRouter>(AppRouterImpl());
  }
}
