import 'package:get_it/get_it.dart';
import 'package:EMO/common/router/router.dart';

class RouteDI {
  RouteDI._();

  static Future<void> init(GetIt injector) async {
    injector.registerSingleton<AppRouter>(AppRouterImpl());
  }
}
