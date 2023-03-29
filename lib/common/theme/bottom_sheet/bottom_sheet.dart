import 'package:flutter/material.dart';
import 'package:EMO/common/styles/main_styles.dart';

typedef ButtonSheetBuilder = Widget Function(
  BuildContext context,
  ScrollController controller,
);

class CustomBottomSheet {
  const CustomBottomSheet._();

  static Future<T?> buttonSheetScrollable<T>(
    BuildContext btnContext, {
    required ButtonSheetBuilder builder,
    double? initialChildSize,
    double? minChildSize,
    double? maxChildSize,
    Radius? radius,
    Color? backgroundColor,
  }) =>
      showModalBottomSheet<T>(
        context: btnContext,
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: backgroundColor ?? Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: radius ?? Corners.medRadius,
          ),
        ),
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: initialChildSize ?? 0.45,
          minChildSize: minChildSize ?? 0.2,
          maxChildSize: maxChildSize ?? 1,
          builder: builder,
        ),
      );

  static Future<T?> simpleButtonSheet<T>(
    BuildContext btnContext, {
    required Widget Function(BuildContext) builder,
    Radius? radius,
    Color? backgroundColor,
  }) =>
      showModalBottomSheet<T>(
        context: btnContext,
        backgroundColor: backgroundColor ?? Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: radius ?? Corners.medRadius,
          ),
        ),
        builder: builder,
      );
}
