import 'dart:async';

import 'package:get/get.dart';
import 'package:tcp_socket_flutter/tcp_socket_flutter.dart';

class IPSetupState {
  final _deviceInfo = Rx<DeviceInfo>(DeviceInfo.none);

  void setDeviceInfo(DeviceInfo deviceInfo) => _deviceInfo.value = deviceInfo;

  DeviceInfo get deviceInfo => _deviceInfo.value;

  /// Server

  /// State
  List<String> _subnets = [];
  final Rx<SocketServerInfo> _ssInfoServer = Rx<SocketServerInfo>(SocketServerInfo.none);
  final _listSocketConnection = Rx<List<SocketConnection>>([]);

  /// Getter
  List<String> get subnets => _subnets;

  SocketServerInfo get ssInfoServer => _ssInfoServer.value;

  List<SocketConnection> get listSocketConnection => _listSocketConnection.value;

  /// Setter
  void setSubnets(List<String> subnets) => _subnets = subnets;

  void setSsInfoServer(SocketServerInfo socketServerInfo) => _ssInfoServer.value = socketServerInfo;

  void setListSocketConnection(List<SocketConnection> listSocketConnection) =>
      _listSocketConnection.value = listSocketConnection;

  /// Function
  void addSubnet(String subnet) {
    final newSubnets = {...subnets, subnet}.toList();
    setSubnets(newSubnets);
  }

  /// ------------------------------------------------------------------------

  /// Client

  /// State
  final Rx<SocketServerInfo> _ssInfoClient = Rx<SocketServerInfo>(SocketServerInfo.none);
  final RxString _currentConnectServerIP = RxString('');
  final RxList<String> _serverIPs = RxList<String>([]);
  final List<StreamSubscription<String>> _streamSubscriptionsSubnet = [];

  /// Getter
  SocketServerInfo get ssInfoClient => _ssInfoClient.value;

  String get currentConnectServerIP => _currentConnectServerIP.value;

  List<String> get serverIPs => _serverIPs;

  /// Setter
  void setSsInfoClient(SocketServerInfo ssInfo) => _ssInfoClient.value = ssInfo;

  void setCurrentConnectServerIP(String ip) => _currentConnectServerIP.value = ip;

  void setServerIPs(List<String> ips) => _serverIPs.value = ips;

  /// Function
  void addServerIP(String ip) {
    final newServerIPs = {...serverIPs, ip}.toList();
    setServerIPs(newServerIPs);
  }

  void addStreamSubscriptionsSubnet(StreamSubscription<String> streamSubscription) =>
      _streamSubscriptionsSubnet.add(streamSubscription);

  Future clearStreamSubscriptionsSubnet() async {
    for (final streamSubscription in _streamSubscriptionsSubnet) {
      streamSubscription.pause();
      await streamSubscription.cancel();
    }
    _streamSubscriptionsSubnet.clear();
  }

  /// ------------------------------------------------------------------------
}
