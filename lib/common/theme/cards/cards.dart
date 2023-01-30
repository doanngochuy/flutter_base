import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';

class CustomCard {
  const CustomCard._();

  static Widget card1({
    Key? key,
    required Widget child,
    double? width,
    double? height,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    Color? color,
    List<BoxShadow>? boxShadow,
    BorderRadiusGeometry? borderRadius,
    BoxBorder? border,
  }) =>
      Container(
        key: key,
        height: height,
        width: width,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: color ?? AppColor.white,
          boxShadow: boxShadow ?? Shadows.cards,
          borderRadius: borderRadius ?? Corners.medBorder,
          border: border,
        ),
        child: child,
      );

  @Deprecated(
    "Recommend use card1",
  )
  static Widget card2({
    Key? key,
    required Widget child,
    double? width,
    double? height,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double? elevation,
    BorderRadiusGeometry? borderRadius,
    Color? color,
    Color? shadowColor,
    BoxBorder? border,
  }) {
    return Card(
      key: key,
      elevation: elevation ?? 2,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? Corners.medBorder,
      ),
      color: color,
      shadowColor: shadowColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border,
        ),
        padding: padding,
        child: child,
      ),
    );
  }
}
