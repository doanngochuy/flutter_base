import 'package:flutter/material.dart';
import 'package:EMO/common/styles/styles.dart';

class CustomTag {
  static Widget tagSuccess(String value) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.successColor,
        borderRadius: Corners.smBorder,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Insets.sm,
        vertical: Insets.xs / 2,
      ),
      child: Text(
        value,
        style: TextStyles.body2.copyWith(
          color: AppColor.white,
          height: 0,
        ),
      ),
    );
  }

  static Widget tagFailure(String value) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.errorColor,
        borderRadius: Corners.smBorder,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Insets.sm,
        vertical: Insets.xs / 2,
      ),
      child: Text(
        value,
        style: TextStyles.body2.copyWith(
          color: AppColor.white,
          height: 0,
        ),
      ),
    );
  }

  static Widget tagWarning(String value) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.warnColor,
        borderRadius: Corners.smBorder,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Insets.sm,
        vertical: Insets.xs / 2,
      ),
      child: Text(
        value,
        style: TextStyles.body2.copyWith(
          color: AppColor.white,
          height: 0,
        ),
      ),
    );
  }

  static Widget tagInfo(String value) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.blueLight,
        borderRadius: Corners.smBorder,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Insets.sm,
        vertical: Insets.xs / 2,
      ),
      child: Text(
        value,
        style: TextStyles.body2.copyWith(
          color: AppColor.white,
          height: 0,
        ),
      ),
    );
  }
}
