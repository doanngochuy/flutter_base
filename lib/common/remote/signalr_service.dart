import 'package:http/http.dart';
import 'package:flutter_base/common/di/injector.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/common/utils/logger.dart';
// import 'package:signalr_core/signalr_core.dart';

abstract class SignalRService {
  static SignalRService get to => AppInjector.injector<SignalRService>();

  // HubConnection get connection;

  SignalRService init();

  Future start();

  void sendNotify(String message);

  Future<void> stop();
}

class SignalRServiceImpl implements SignalRService {

  // late HubConnection _connection;

  // @override
  // HubConnection get connection => _connection;

  @override
  SignalRServiceImpl init() => this;

  @override
  Future<void> start() async {
    if (!UserStore.to.isLogin.value) return;

    final httpClient = HttpClient(defaultHeaders: {
      "User-Agent": "",
    });

    Logger.write("SignalR: header ss-id= ${httpClient.defaultHeaders.values}");

    // final option = HttpConnectionOptions(
    //   skipNegotiation: true,
    //   transport: HttpTransportType.webSockets,
    //   client: httpClient,
    //   logging: (level, message) => Logger.write("signalR: $level $message"),
    // );
    //
    // _connection = HubConnectionBuilder().withUrl('', option).withAutomaticReconnect().build();
    //
    // await _connection
    //     .start()
    //     ?.then((value) => Logger.write("ReceiveMessage start ok"))
    //     .catchError((e) => Logger.write("ReceiveMessage start error $e"));
    //
    // _connection.on('ShowNotify', (message) {
    //   Logger.write("signalR: ReceiveMessage$message");
    // });
    //
    // _connection.on('Update', (message) {
    //   Logger.write("signalR: ReceiveMessage$message");
    // });
  }

  @override
  void sendNotify(String message) {
    Logger.write("sendNotify: $message");
    // _connection
    //     .invoke($methodNotify, args: [message])
    //     .then((value) => Logger.write("sendNotify done $value"))
    //     .onError((error, stackTrace) => Logger.write("sendNotify error"));
  }

  @override
  Future<void> stop() async {
    // await connection.stop();
  }
}

class HttpClient extends BaseClient {
  final _httpClient = Client();
  final Map<String, String> defaultHeaders;

  HttpClient({required this.defaultHeaders});

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers.addAll(defaultHeaders);
    return _httpClient.send(request);
  }
}
