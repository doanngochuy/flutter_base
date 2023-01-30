import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_base/common/di/injector.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/service/service.dart';
import 'package:flutter_base/common/theme/theme.dart';

abstract class NetworkConnectionService {
  static NetworkConnectionService get to => AppInjector.injector<NetworkConnectionService>();

  Future initListener();

  void disposeListener();

  Future<ConnectivityResult> getConnectivityResult();

  ConnectivityResult get connectivityResult;
}

class NetworkConnectionServiceImpl implements NetworkConnectionService {
  StreamSubscription<ConnectivityResult>? _listener;
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  void _setConnectionStatus(ConnectivityResult value) => _connectionStatus = value;

  void _updateConnectionStatus(ConnectivityResult result) {
    _setConnectionStatus(result);
    if (result == ConnectivityResult.none) CustomToast.error(msg: S.current.Mat_ket_noi_mang);
    AppStream.to.emit(StatusNetworkState(_connectionStatus));
  }

  @override
  Future initListener() async {
    _setConnectionStatus(await getConnectivityResult());
    _listener = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void disposeListener() => _listener?.cancel();

  @override
  Future<ConnectivityResult> getConnectivityResult() async {
    _setConnectionStatus(await _connectivity.checkConnectivity());
    return _connectionStatus;
  }

  @override
  ConnectivityResult get connectivityResult => _connectionStatus;
}
