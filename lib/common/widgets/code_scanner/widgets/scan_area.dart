import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/service/service.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/utils/utils.dart';

import '../controller.dart';

class ScanAreaWidget extends StatelessWidget {
  final ScannerMode mode;

  const ScanAreaWidget({
    Key? key,
    required this.mode,
  }) : super(key: key);

  Size borderSize(BuildContext context) {
    final baseBorder = 24.scaleSize;
    late final double borderWidth, borderHeight;

    switch (context.orientation) {
      case Orientation.portrait:
        final square = context.width - (baseBorder * 2);
        borderHeight = (context.height - square) / 2;
        borderWidth = baseBorder;
        break;
      case Orientation.landscape:
        final square = context.height - baseBorder * 2;
        borderWidth = (context.width - square) / 2;
        borderHeight = baseBorder;
        break;
    }

    return Size(borderWidth, borderHeight);
  }

  @override
  Widget build(BuildContext context) {
    final size = borderSize(context);

    final color = Colors.black12.withOpacity(0.5);
    Border border;
    String text;
    switch (mode) {
      case ScannerMode.popup:
        border = Border.all(color: color, width: 24.scaleSize);
        text = S.current.Quet_ma;
        break;
      case ScannerMode.fullscreen:
        border = Border.symmetric(
          vertical: BorderSide(color: color, width: size.width),
          horizontal: BorderSide(color: color, width: size.height),
        );
        text = S.current.Quet_barcode_hoac_QRCode;
        break;
    }

    return Stack(
      children: [
        MobileScanner(
          fit: BoxFit.cover,
          allowDuplicates: false,
          onDetect: (capture, arguments) {
            final state = CodeScanned(capture);

            AppStream.to.emit(state);

            if (mode == ScannerMode.fullscreen) context.popNavigator();
          },
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(border: border),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyles.body1.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
