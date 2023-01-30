import 'package:mobile_scanner/mobile_scanner.dart';

import 'abstract_state.dart';

class CodeScanned extends AppState<String> {
  final Barcode barcode;

  CodeScanned(this.barcode) : super(barcode.rawValue ?? '');

  @override
  List<Object?> get props => [data];
}
