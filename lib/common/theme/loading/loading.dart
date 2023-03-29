import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/utils/utils.dart';

class Loading {
  Loading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 35.0
      ..lineWidth = 2
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.black.withOpacity(0.7)
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = true
      ..dismissOnTap = false
      ..maskType = EasyLoadingMaskType.custom;
  }

  static void show([String? text]) {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show(status: text ?? '${S.current.Dang_tai}...');
  }

  static void toast(
    String text, {
    EasyLoadingToastPosition position = EasyLoadingToastPosition.bottom,
  }) =>
      EasyLoading.showToast(
        text,
        toastPosition: EasyLoadingToastPosition.bottom,
      );

  static void dismiss() {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.dismiss();
  }

  static Future<T?> openAndDismissLoading<T>(AsyncValueGetter<T?> callback) async {
    try {
      show();
      final T? result = await callback();
      dismiss();
      return result;
    } catch (e) {
      debugConsoleLog('openAndDismissLoading: $e}');
      dismiss();
    }
    return null;
  }
}
