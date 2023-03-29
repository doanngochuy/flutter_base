import 'package:get_it/get_it.dart';
import 'package:EMO/common/remote/remote.dart';
import 'package:EMO/common/service/service.dart';

class ServiceDI {
  ServiceDI._();

  static Future<void> init(GetIt injector) async {
    injector.registerSingleton<SignalRService>(SignalRServiceImpl().init());
    injector.registerSingleton<AppStream>(AppStreamImpl());
    injector.registerLazySingleton<SearchStream>(SearchStreamImpl.init);
    injector.registerSingleton<NetworkConnectionService>(NetworkConnectionServiceImpl());
    injector.registerSingleton<TCPSocketClientService>(TCPSocketClientServiceImpl());
    injector.registerSingleton<TCPSocketServerService>(TCPSocketServerServiceImpl());
  }
}
