import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/utils/utils.dart';
import 'package:flutter_base/global.dart';

class CustomSnackBar {
  static final CustomSnackBar _instance = CustomSnackBar._internal();
  static const double maxWidthSnackBar = 550;

  factory CustomSnackBar() {
    return _instance;
  }

  CustomSnackBar._internal();

  static void success({
    required String title,
    required String message,
    Duration? duration = Times.verySlower,
    SnackPosition snackPosition = SnackPosition.TOP,
  }) {
    Global.snackBarKey.currentState?.showSnackBar(
      SnackBar(
        content: ListTile(
          textColor: Colors.white,
          leading: Icon(
            CustomIcons.ok_circled,
            size: Insets.xl,
            color: AppColor.white,
          ),
          title: Text(
            title,
            style: TextStyles.title1.copyWith(
              color: AppColor.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            message,
            style: TextStyles.title2.copyWith(
              color: AppColor.white,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
        duration: duration ?? const Duration(milliseconds: 4000),
        backgroundColor: AppColor.successColor,
        padding: EdgeInsets.symmetric(
          horizontal: Insets.lg,
          vertical: Insets.sm,
        ),
        margin: EdgeInsets.all(Insets.lg),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void error({
    required String title,
    required String message,
    Duration? duration = Times.verySlower,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
  }) {
    Global.snackBarKey.currentState?.showSnackBar(
      SnackBar(
        content: ListTile(
          textColor: Colors.white,
          leading: Icon(
            CustomIcons.attention_circled,
            size: Insets.xl,
            color: AppColor.white,
          ),
          title: Text(
            title,
            style: TextStyles.title1.copyWith(
              color: AppColor.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            message,
            style: TextStyles.title2.copyWith(
              color: AppColor.white,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
        duration: duration ?? const Duration(milliseconds: 4000),
        backgroundColor: AppColor.errorColor,
        padding: EdgeInsets.symmetric(
          horizontal: Insets.lg,
          vertical: Insets.sm,
        ),
        margin: EdgeInsets.all(Insets.lg),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void warning({
    required String title,
    required String message,
    Duration? duration = Times.verySlower,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
  }) {
    Global.snackBarKey.currentState?.showSnackBar(
      SnackBar(
        content: ListTile(
          textColor: Colors.white,
          leading: Icon(
            CustomIcons.attention,
            size: Insets.xl,
            color: AppColor.white,
          ),
          title: Text(
            title,
            style: TextStyles.title1.copyWith(
              color: AppColor.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            message,
            style: TextStyles.title2.copyWith(
              color: AppColor.white,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
        duration: duration ?? const Duration(milliseconds: 4000),
        backgroundColor: AppColor.warnColor,
        padding: EdgeInsets.symmetric(
          horizontal: Insets.lg,
          vertical: Insets.sm,
        ),
        margin: EdgeInsets.all(Insets.lg),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void info({
    required String title,
    required String message,
    Duration? duration = Times.verySlower,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
  }) {
    Global.snackBarKey.currentState?.showSnackBar(
      SnackBar(
        content: ListTile(
          textColor: Colors.white,
          leading: Icon(
            CustomIcons.info_circled,
            size: Insets.xl,
            color: AppColor.white,
          ),
          title: Text(
            title,
            style: TextStyles.title1.copyWith(
              color: AppColor.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            message,
            style: TextStyles.title2.copyWith(
              color: AppColor.white,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
        duration: duration ?? const Duration(milliseconds: 4000),
        backgroundColor: AppColor.infoColor,
        padding: EdgeInsets.symmetric(
          horizontal: Insets.lg,
          vertical: Insets.sm,
        ),
        margin: EdgeInsets.all(Insets.lg),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
