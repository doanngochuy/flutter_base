import 'package:flutter/material.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/common/styles/styles.dart';

/// Constant width for further calculation
double widthWhenHaveShowMore({double? totalWidth}) =>
    (totalWidth ?? ConfigStore.to.deviceWidth) * 0.02;

Widget wrapItemBorder({required Widget child, required int index}) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(
          width: index == 0 ? 0 : Strokes.thick / 2,
          color: AppColor.grey300,
        ),
      ),
    ),
    child: child,
  );
}

Widget wrapItem({required Widget child, double? width, required int index, int? flex}) {
  return width != null
      ? SizedBox(
          width: width,
          child: wrapItemBorder(child: child, index: index),
        )
      : Expanded(
          flex: flex ?? 1,
          child: wrapItemBorder(child: child, index: index),
        );
}

Widget wrapItemWithOutBorder({required Widget child, double? width, int? flex}) {
  return width != null
      ? SizedBox(width: width, child: child)
      : Expanded(flex: flex ?? 1, child: child);
}
