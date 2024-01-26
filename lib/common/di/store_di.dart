import 'package:get_it/get_it.dart';
import 'package:EMO/common/store/store.dart';

class StoreDI {
  StoreDI._();

  static Future<void> init(GetIt injector) async {
    injector.registerSingleton<ConfigStore>(ConfigStore());
    injector.registerSingleton<UserStore>(UserStoreImpl());
    injector.registerSingleton<JobStore>(JobStoreImpl());
    injector.registerSingleton<WithdrawStore>(WithdrawStoreImpl());
    injector.registerSingleton<AppConfigureStore>(AppConfigureStoreImpl());
  }
}
