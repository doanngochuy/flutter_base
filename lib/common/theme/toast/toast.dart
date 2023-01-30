import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_base/common/styles/styles.dart';

class CustomToast {
  static Future<bool?> info({
    required String msg,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    ToastGravity? gravity,
    Toast? toastLength,
  }) =>
      Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength ?? Toast.LENGTH_SHORT,
        gravity: gravity ?? ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        webBgColor: '#${backgroundColor.value.toRadixString(16).substring(2, 8)}',
        textColor: textColor,
        fontSize: 16,
      );

  static Future<bool?> success({
    required String msg,
    Color textColor = Colors.white,
    ToastGravity? gravity,
    Toast? toastLength,
  }) =>
      info(
        msg: msg,
        backgroundColor: AppColor.successColor,
        textColor: textColor,
        gravity: gravity,
        toastLength: toastLength,
      );

  static Future<bool?> error({
    required String msg,
    Color textColor = Colors.white,
    ToastGravity? gravity,
    Toast? toastLength,
  }) =>
      info(
        msg: msg,
        backgroundColor: AppColor.errorColor,
        textColor: textColor,
        gravity: gravity,
        toastLength: toastLength,
      );

  static Future<bool?> noty({
    required String msg,
    Color textColor = Colors.white,
    ToastGravity? gravity,
    Toast? toastLength,
  }) =>
      info(
        msg: msg,
        backgroundColor: AppColor.blueLight,
        textColor: textColor,
        gravity: gravity,
        toastLength: toastLength,
      );
}
