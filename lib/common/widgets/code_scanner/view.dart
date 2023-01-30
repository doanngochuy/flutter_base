import 'package:flutter/material.dart';

import 'controller.dart';
import 'layouts/layouts.dart';

class CodeScannerWidget extends StatelessWidget {
  final ScannerMode mode;

  const CodeScannerWidget({
    this.mode = ScannerMode.popup,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case ScannerMode.popup:
        return const CodeScannerPopupWidget();
      case ScannerMode.fullscreen:
        return const CodeScannerFullScreenWidget();
    }
  }
}
