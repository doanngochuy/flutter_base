import 'package:EMO/common/service/app_stream/app_stream.dart';
import 'package:tcp_socket_flutter/tcp_socket_flutter.dart';

class SSInfoClientState extends AppState<SocketServerInfo> {
  final SocketServerInfo socketServerInfo;

  const SSInfoClientState(this.socketServerInfo) : super(socketServerInfo);

  @override
  List<Object?> get props => [data];
}
