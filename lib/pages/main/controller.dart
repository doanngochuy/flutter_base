import 'dart:async';

import 'package:EMO/common/router/router.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:get/get.dart';

import 'index.dart';

class MainController extends GetxController {
  static MainController get to => Get.find<MainController>();

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
    await _initListener();
  }

  void disposeService() {
    // NetworkConnectionService.to.disposeListener();
  }

  Future _initListener() async {
    // await NetworkConnectionService.to.initListener();
  }
}
