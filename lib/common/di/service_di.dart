import 'package:EMO/common/service/service.dart';
import 'package:get_it/get_it.dart';

class ServiceDI {
  ServiceDI._();

  static Future<void> init(GetIt injector) async {
    injector.registerSingleton<AppStream>(AppStreamImpl());
    injector.registerLazySingleton<SearchStream>(SearchStreamImpl.init);
    injector.registerSingleton<NetworkConnectionService>(NetworkConnectionServiceImpl());
    injector.registerSingleton<AnalyticsService>(FireBaseAnalyticsService());
  }
}
