import 'dart:async';

import 'package:get/get.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/models/models.dart';
import 'package:EMO/common/service/service.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tcp_socket_flutter/tcp_socket_flutter.dart';

import 'state.dart';

class IPSetupController extends GetxController {
  static IPSetupController get to => Get.find<IPSetupController>();

  final state = IPSetupState();

  /// Server
  late StreamSubscription<DeviceInfo> _streamSubscription;
  late StreamSubscription<List<SocketConnection>> _streamSubscriptionListSocketConnection;
  late StreamSubscription<SSInfoServerState> _streamSubscriptionSSInfoServer;

  /// Logic
  void initServer() => Loading.openAndDismissLoading(
        () async {
          if (state.ssInfoServer.serverIsRunning) {
            CustomToast.noty(msg: S.current.Khi_dang_ket_noi_khong_the_thuc_hien_tac_vu_nay);
            return;
          }
          TCPSocketServerService.to.startTCPSocketServer();
          await Future.delayed(TCPSocketServerService.to.socketServer.timeDelayToggleConnect);
        },
      );

  void disposeServer() => Loading.openAndDismissLoading(
        () async {
          if (!state.ssInfoServer.serverIsRunning) {
            CustomToast.noty(msg: S.current.Ban_dang_khong_ket_noi_voi_may_thu_ngan_nao);
            return;
          }
          TCPSocketServerService.to.disposeTCPSocketServer();
          await Future.delayed(TCPSocketServerService.to.socketServer.timeDelayToggleConnect);
        },
      );

  void reloadServer() => Loading.openAndDismissLoading(
        () async {
          await TCPSocketServerService.to.disposeTCPSocketServer();
          await Future.delayed(TCPSocketServerService.to.socketServer.timeDelayToggleConnect);
          await TCPSocketServerService.to.startTCPSocketServer();
        },
      );

  /// -----------------------------------------------------------------------------

  /// Client
  late StreamSubscription<SSInfoClientState> _streamSubscriptionSSInfoClient;

  /// Logic

  Future discoverServerIP() => Loading.openAndDismissLoading(
        () async {
          await state.clearStreamSubscriptionsSubnet();
          for (String subnet in state.subnets) {
            final Stream<String> stream =
                TCPSocketClientService.to.socketClient.discoverServerIP(subnet);
            final StreamSubscription<String> subscription = stream.listen(
              (ip) {
                if (ip.isNotEmpty) state.addServerIP(ip);
              },
            );
            state.addStreamSubscriptionsSubnet(subscription);
          }
          await Future.delayed(TCPSocketServerService.to.socketServer.timeDelayToggleConnect);
        },
      );

  Future<bool> connectToServer(String ip) async {
    if (state.ssInfoClient.serverIsRunning) {
      CustomToast.noty(msg: S.current.Khi_dang_ket_noi_khong_the_thuc_hien_tac_vu_nay);
      return false;
    }
    return await Loading.openAndDismissLoading<bool>(
          () async {
        final result = await TCPSocketClientService.to.connectToServer(ip);
            if (result) {
              state.addServerIP(ip);
              state.setCurrentConnectServerIP(ip);
            }
            state.setSsInfoClient(
              state.ssInfoClient.copyWith(
                serverIsRunning: result,
              ),
            );
            await Future.delayed(TCPSocketClientService.to.socketClient.timeDelayToggleConnect);
            return result;
          },
        ) ??
        false;
  }

  Future disconnectToServer() => Loading.openAndDismissLoading(
        () async {
          await TCPSocketClientService.to.disconnectToServer();
          state.setSsInfoClient(SocketServerInfo.none);
          state.setCurrentConnectServerIP('');
          await Future.delayed(TCPSocketClientService.to.socketClient.timeDelayToggleConnect);
        },
      );

  Future<bool> addIPManual(List<String> numbers) async {
    final List<String> listSubIP = [];
    for (String number in numbers) {
      if (number.isNotEmpty) {
        listSubIP.add(number);
      }
    }
    if (state.ssInfoClient.serverIsRunning) {
      CustomToast.noty(msg: S.current.Khi_dang_ket_noi_khong_the_thuc_hien_tac_vu_nay);
      return false;
    }
    if (listSubIP.length < 3) {
      CustomToast.error(msg: S.current.Ban_nhap_chua_dung_dinh_dang_dia_chi_ip);
      return false;
    }
    if (listSubIP.length == 3) {
      final subnet = listSubIP.join('.');
      if (state.subnets.contains(subnet)) {
        CustomToast.error(msg: S.current.Dia_chi_ip_nay_da_duoc_them_truoc_do);
        return false;
      }
      state.addSubnet(subnet);
      await discoverServerIP();
      return false;
    }
    final ip = listSubIP.join('.');
    if (state.serverIPs.contains(ip)) {
      CustomToast.error(msg: S.current.Dia_chi_ip_nay_da_duoc_them_truoc_do);
      return false;
    }
    final result = await connectToServer(ip);
    if (!result) {
      CustomToast.error(msg: S.current.Khong_the_ket_noi_den_dia_chi_ip_nay);
    }
    return result;
  }

  Future reloadAll() => Loading.openAndDismissLoading(
        () async {
          if (ConfigStore.to.typeLogin == TypeLogin.cashiers) {
            if (state.ssInfoServer.serverIsRunning) {
              await TCPSocketServerService.to.disposeTCPSocketServer();
            }
          }
          if (state.ssInfoClient.serverIsRunning) {
            await TCPSocketClientService.to.disconnectToServer();
          }
          await TCPSocketSetUp.init();
        },
      );

  /// -----------------------------------------------------------------------------

  /// Common
  void initData() {
    state.setDeviceInfo(TCPSocketSetUp.deviceInfo);
    if (state.deviceInfo.isNotNone()) state.setSubnets([state.deviceInfo.subnet]);
    _streamSubscription = TCPSocketSetUp.streamDeviceInfoStream.listen(
      (event) {
        state.setDeviceInfo(event);
        if (state.deviceInfo.isNotNone()) state.addSubnet(event.subnet);
      },
    );

    /// For server
    state.setSsInfoServer(TCPSocketServerService.to.socketServerInfo);
    _streamSubscriptionSSInfoServer =
        AppStream.to.stateStream.whereType<SSInfoServerState>().listen(
              (event) => state.setSsInfoServer(event.socketServerInfo),
            );
    state.setListSocketConnection(TCPSocketServerService.to.listSocketConnection);
    _streamSubscriptionListSocketConnection =
        TCPSocketServerService.to.listenerListSocketConnection.listen(
      (event) => state.setListSocketConnection(List.from(event)),
    );

    /// For client
    state.setSsInfoClient(TCPSocketClientService.to.socketServerInfo);
    _streamSubscriptionSSInfoClient =
        AppStream.to.stateStream.whereType<SSInfoClientState>().listen(
      (event) {
        state.setSsInfoClient(event.socketServerInfo);
        if (!state.ssInfoClient.isNotNone()) state.setCurrentConnectServerIP('');
      },
    );
  }

  void disposeData() {
    _streamSubscription.pause();
    _streamSubscription.cancel();
    _streamSubscriptionListSocketConnection.pause();
    _streamSubscriptionListSocketConnection.cancel();
    _streamSubscriptionSSInfoServer.pause();
    _streamSubscriptionSSInfoServer.cancel();
    _streamSubscriptionSSInfoClient.pause();
    _streamSubscriptionSSInfoClient.cancel();
  }
}
