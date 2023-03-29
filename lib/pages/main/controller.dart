import 'dart:async';

import 'package:get/get.dart';
import 'package:EMO/common/models/models.dart';
import 'package:EMO/common/router/router.dart';
import 'package:EMO/common/service/service.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:tcp_socket_flutter/tcp_socket_flutter.dart';

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
    // _intTCPSocket();
  }

  void disposeService() {
    // NetworkConnectionService.to.disposeListener();
    // TCPSocketClientService.to.disconnectToServer();
    // TCPSocketServerService.to.disposeTCPSocketServer();
    // TCPSocketClientService.to.disposeListenNetwork();
    // TCPSocketServerService.to.disposeListenNetwork();
  }

  Future _intTCPSocket() async {
    TCPSocketSetUp.setConfig(TCPSocketConstants.$config);
    await TCPSocketSetUp.init();
    if (ConfigStore.to.typeLogin == TypeLogin.cashiers && !isWeb) {
      TCPSocketServerService.to.startTCPSocketServer();
    }
  }

  Future _initListener() async {
    // await NetworkConnectionService.to.initListener();
    // TCPSocketClientService.to.listenNetwork();
    // TCPSocketServerService.to.listenNetwork();
  }
}
