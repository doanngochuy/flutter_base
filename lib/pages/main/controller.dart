import 'dart:async';

import 'package:EMO/common/router/router.dart';
import 'package:EMO/common/service/service.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:get/get.dart';

import 'index.dart';

class MainController extends GetxController {
  static MainController get to => Get.find<MainController>();

  List<BaseService> get services => [
        AnalyticsService.to,
      ];

  final state = MainState();

  void initMain(ScreenRouter initPageName) async {
    try {
      state.setCurrentPage(initPageName);
      await _syncAllData();
      _initService();
    } catch (e) {
      debugConsoleLog(e);
    }
  }

  Future _syncAllData() => Future.wait([]);

  void _initService() async {
    for (final e in services) {
      e.initService();
    }
  }

  void disposeService() {
    try {
      for (final e in services) {
        e.disposeService();
      }
    } catch (e) {
      Logger.write(e.toString());
    }
  }
}
