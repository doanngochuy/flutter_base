import 'package:tcp_socket_flutter/tcp_socket_flutter.dart';

class TCPSocketConstants {
  static const int $port = 3001;
  static const Duration $timeoutEachTimesSendData = Duration(milliseconds: 500);
  static const int $numberSplit = 10000;

  static const SocketConfig $config = SocketConfig(
    port: $port,
    numberSplit: $numberSplit,
    timeoutEachTimesSendData: $timeoutEachTimesSendData,
  );
}
