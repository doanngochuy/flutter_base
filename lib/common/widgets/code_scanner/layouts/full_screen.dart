import 'package:flutter/material.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/utils/utils.dart';

import '../controller.dart';
import '../widgets/widgets.dart';

class CodeScannerFullScreenWidget extends StatelessWidget {
  const CodeScannerFullScreenWidget({
    Key? key,
  }) : super(key: key);

  void enterPopupMode(BuildContext context) => context.popNavigator(ScannerMode.popup);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const ScanAreaWidget(mode: ScannerMode.fullscreen),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close, color: AppColor.white, size: 30.scaleSize),
                onPressed: context.popNavigator,
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(Icons.fullscreen_exit, color: AppColor.white, size: 36.scaleSize),
                onPressed: () => enterPopupMode(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
