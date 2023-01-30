import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_base/common/di/injector.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/service/service.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/common/utils/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tcp_socket_flutter/tcp_socket_flutter.dart';

abstract class TCPSocketClientService {
  static TCPSocketClientService get to => AppInjector.injector<TCPSocketClientService>();

  void listenNetwork();

  void disposeListenNetwork();

  TCPSocketClient get socketClient;

  SocketServerInfo get socketServerInfo;

  Future<bool> connectToServer(String ip);

  Future disconnectToServer();
}

class TCPSocketClientServiceImpl implements TCPSocketClientService {
  final TCPSocketClient _socketClient = TCPSocketClient();
  SocketServerInfo _socketServerInfo = SocketServerInfo.none;
  StreamSubscription<StatusNetworkState>? _listenerNetwork;

  void _setSocketServerInfo(SocketServerInfo value) {
    _socketServerInfo = value;
    AppStream.to.emit(SSInfoClientState(value));
  }

  void _setListenerNetwork(StreamSubscription<StatusNetworkState>? listener) =>
      _listenerNetwork = listener;

  @override
  void listenNetwork() => _setListenerNetwork(
        AppStream.to.stateStream.whereType<StatusNetworkState>().listen(
          (statusState) {
            if (statusState.connectivityResult == ConnectivityResult.none) disconnectToServer();
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
  TCPSocketClient get socketClient => _socketClient;

  void _onData(TCPSocketEvent event) {
    final String data = event.data;
    final type = TCPSocketServerEvent.fromString(event.type);
    switch (type) {
      case TCPSocketServerEvent.serverSendInfo:
        final infoServer = SocketServerInfo.fromJsonString(event.data);
        _setSocketServerInfo(infoServer);
        break;
      case TCPSocketServerEvent.synchronizeOrderToClient:
        CustomToast.noty(msg: S.current.Vua_dong_bo_voi_thu_ngan);
        break;

      /// something
      case TCPSocketServerEvent.sendSomething:
        debugConsoleLog('Server sendSomething length-${data.length}: $data');
        break;
    }
  }

  void _onDone() {
    _setSocketServerInfo(SocketServerInfo.none);
    CustomToast.noty(msg: S.current.Mat_ket_noi_voi_may_thu_ngan);
  }

  void _onError(dynamic error) => debugConsoleLog('TCPSocketClientService error: $error');

  @override
  Future<bool> connectToServer(String ip) async {
    try {
      final result = await _socketClient.connectToServer(
        ip,
        onData: _onData,
        onDone: _onDone,
        onError: _onError,
      );
      _socketClient.sendData(
        FormDataSending(
          type: TCPSocketClientEvent.connectToServer.name,
          data: TCPSocketSetUp.deviceInfo
              .copyWith(
                moreInfo: ConfigStore.to.typeLogin?.name,
                sourcePort: _socketClient.socketChannel?.sourcePort,
              )
              .toJsonString(),
        ),
      );
      return result;
    } catch (e) {
      debugConsoleLog('Error connectToServer: $e');
      CustomToast.error(
        msg:
            '${S.current.Khong_the_ket_noi_den_may_thu_ngan} ${S.current.hoac} ${S.current.Khong_tim_thay_may_thu_ngan_nao}',
        toastLength: Toast.LENGTH_LONG,
      );
      return false;
    }
  }

  @override
  Future disconnectToServer() async => _socketClient.disposeConnection();
}
