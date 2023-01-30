import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/utils/utils.dart';

import '../controller.dart';
import '../widgets/widgets.dart';

class CodeScannerPopupWidget extends StatelessWidget {
  const CodeScannerPopupWidget({
    Key? key,
  }) : super(key: key);

  void enterFullScreenMode(BuildContext context) => context.popNavigator(ScannerMode.fullscreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: Corners.custom20Border,
            child: SizedBox(
              width: 240.scaleSize,
              height: 240.scaleSize,
              child: Stack(
                children: [
                  const ScanAreaWidget(mode: ScannerMode.popup),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white, size: 30.scaleSize),
                      onPressed: context.popNavigator,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.fullscreen, color: Colors.white, size: 36.scaleSize),
                      onPressed: () => enterFullScreenMode(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
