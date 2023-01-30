import 'package:connectivity_plus/connectivity_plus.dart';

import 'abstract_state.dart';

class StatusNetworkState extends AppState<ConnectivityResult> {
  final ConnectivityResult connectivityResult;

  const StatusNetworkState(this.connectivityResult) : super(connectivityResult);

  @override
  List<Object?> get props => [data];
}
