import 'package:flutter/material.dart';

import 'controller.dart';
import 'view.dart';

Future<T?> _showOverlay<T>(BuildContext context, {required WidgetBuilder builder}) =>
    Navigator.of(context).push<T>(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      ),
    );

Future<void> showCodeScanner(BuildContext context, {ScannerMode? mode}) async {
  if (mode == null) return;

  final nextMode = await _showOverlay<ScannerMode>(
    context,
    builder: (context) => CodeScannerWidget(mode: mode),
  );

  Future.delayed(
    const Duration(milliseconds: 500),
    () => showCodeScanner(context, mode: nextMode),
  );
}
