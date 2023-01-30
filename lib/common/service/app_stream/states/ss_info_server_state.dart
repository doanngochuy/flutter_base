import 'package:flutter_base/common/service/app_stream/app_stream.dart';
import 'package:tcp_socket_flutter/tcp_socket_flutter.dart';

class SSInfoServerState extends AppState<SocketServerInfo> {
  final SocketServerInfo socketServerInfo;

  const SSInfoServerState(this.socketServerInfo) : super(socketServerInfo);

  @override
  List<Object?> get props => [data];
}
