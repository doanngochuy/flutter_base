import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:EMO/common/di/injector.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/service/service.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tcp_socket_flutter/tcp_socket_flutter.dart';

abstract class TCPSocketServerService {
  static TCPSocketServerService get to => AppInjector.injector<TCPSocketServerService>();

  void listenNetwork();

  void disposeListenNetwork();

  TCPSocketServer get socketServer;

  SocketServerInfo get socketServerInfo;

  List<SocketConnection> get listSocketConnection;

  Stream<List<SocketConnection>> get listenerListSocketConnection;

  Future<bool> startTCPSocketServer();

  Future disposeTCPSocketServer();
}

class TCPSocketServerServiceImpl implements TCPSocketServerService {
  final TCPSocketServer _socketServer = TCPSocketServer();
  SocketServerInfo _socketServerInfo = SocketServerInfo.none;
  StreamSubscription<StatusNetworkState>? _listenerNetwork;

  void _setSocketServerInfo(SocketServerInfo value) {
    _socketServerInfo = value;
    AppStream.to.emit(SSInfoServerState(socketServerInfo));
  }

  void _setListenerNetwork(StreamSubscription<StatusNetworkState>? listener) =>
      _listenerNetwork = listener;

  @override
  void listenNetwork() => _setListenerNetwork(
        AppStream.to.stateStream.whereType<StatusNetworkState>().listen(
          (statusState) {
            if (statusState.connectivityResult == ConnectivityResult.none) disposeTCPSocketServer();
          },
        ),
      );

  @override
  void disposeListenNetwork() {
    _listenerNetwork?.cancel();
    _setListenerNetwork(null);
  }

  @override
  SocketServerInfo get socketServerInfo => _socketServerInfo;

  @override
  TCPSocketServer get socketServer => _socketServer;

  @override
  Stream<List<SocketConnection>> get listenerListSocketConnection =>
      _socketServer.listenerListSocketConnection;

  @override
  List<SocketConnection> get listSocketConnection => _socketServer.listSocketConnection;

  void _onData(String ip, int? sourcePort, TCPSocketEvent event) async {
    final String data = event.data;
    final type = TCPSocketClientEvent.fromString(event.type);

    switch (type) {
      case TCPSocketClientEvent.connectToServer:
        final localInfo = DeviceInfo.fromJsonString(data);
        _socketServer.state.addDeviceInfoToSocketConnection(ip, localInfo);
        _socketServer.sendData(
          FormDataSending(
            type: TCPSocketServerEvent.serverSendInfo.name,
            data: _socketServerInfo.toJsonString(),
          ),
          targetSocketChannels: [_socketServer.state.mapIPToSocketConnection[ip]!.socketChannel],
        );
        CustomToast.success(msg: '${localInfo.deviceName} ${S.current.Da_ket_noi}');
        break;

      case TCPSocketClientEvent.clientSendOrder:
        CustomToast.noty(msg: S.current.Vua_dong_bo_du_lieu_voi_order);
        break;

      /// something
      case TCPSocketClientEvent.sendSomething:
        debugConsoleLog('Client sendSomething length-${data.length}: $data');
        break;
    }
  }

  void _onDone(String ip, int? sourcePort) =>
      CustomToast.noty(msg: '$ip:$sourcePort: ${S.current.Da_ngat_ket_noi}');

  void _onError(dynamic error, String ip, int? sourcePort) {
    debugConsoleLog('TCPSocketServerService $ip:$sourcePort error: $error');
  }

  @override
  Future<bool> startTCPSocketServer() async {
    try {
      final result = await _socketServer.initServer(
        onData: _onData,
        onDone: _onDone,
        onError: _onError,
        onServerDone: _closeServer,
        onServerError: (error) => _closeServer(),
      );
      _setSocketServerInfo(
        SocketServerInfo(
          ip: TCPSocketSetUp.ip,
          deviceServerName: TCPSocketSetUp.deviceName,
          serverIsRunning: true,
          moreInfo: ConfigStore.to.typeLogin?.name,
        ),
      );
      CustomToast.success(msg: '${S.current.Mang_noi_bo} ${S.current.Dang_bat.toLowerCase()}');
      return result;
    } catch (e) {
      debugConsoleLog('Error initServer: $e');
      CustomToast.error(msg: S.current.Dang_co_mot_may_thu_ngan_khac_su_dung_lam_may_chu);
      return false;
    }
  }

  void _closeServer() {
    _setSocketServerInfo(SocketServerInfo.none);
    CustomToast.noty(
      msg: '${S.current.Mang_noi_bo} ${S.current.Dang_tat.toLowerCase()}',
    );
  }

  @override
  Future disposeTCPSocketServer() async {
    if (socketServerInfo == SocketServerInfo.none) return;
    await _socketServer.disposeServer();
    _closeServer();
  }
}
