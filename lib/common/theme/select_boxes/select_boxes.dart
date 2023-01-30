import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_base/common/styles/styles.dart';

typedef CustomTitleCheckBox = Widget Function<T>(T item, bool value);

class CustomSelectBox {
  const CustomSelectBox._();

  /// *** If you want to use [FormBuilder]
  ///
  /// *** Single
  /// * Radio style use [FormBuilderCheckbox]
  /// * Checkbox style use [FormBuilderCheckbox] are wrapped in [CustomSelectBox.singleCheckBox]
  /// and use parameter [isCircle] to change style
  /// because default [FormBuilderCheckbox] is circle
  ///
  /// *** Multiple
  ///
  /// - Select one
  /// * Radio style use [FormBuilderRadioGroup]
  ///
  /// - Select multiple
  /// * Radio style use [FormBuilderCheckboxGroup]
  /// * Checkbox style use [FormBuilderCheckboxGroup] are wrapped in [CustomSelectBox.singleCheckBox]
  /// and use parameter [isCircle] to change style
  /// because default [FormBuilderCheckboxGroup] is circle

  static Widget themeSelectBox({
    required Widget child,
    bool isCircle = true,
    Color? fillColor,
  }) =>
      Theme(
        data: ThemeData(
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.all(fillColor ?? AppColor.grey600),
            shape: isCircle
                ? const CircleBorder()
                : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                Strokes.thin,
              ),
            ),
          ),
        ),
        child: child,
      );

  /// with out [FormBuilder]
  static Widget simpleCheckBox({
    required bool value,
    required Function(bool?) onChanged,
    bool isCircle = true,
    Color? activeColor,
    Color? checkColor,
    Color? fillColor,
  }) =>
      themeSelectBox(
        isCircle: isCircle,
        fillColor: fillColor,
        child: Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor ?? AppColor.blueLight,
          checkColor: checkColor ?? (isCircle ? AppColor.blueLight : AppColor.white),
        ),
      );

  /// with out [FormBuilder]
  static Widget singleCheckBox({
    required Widget title,
    Widget? subtitle,
    Widget? secondary,
    required bool value,
    required Function(bool?)? onChanged,
    bool isCircle = true,
    Color? fillColor,
    Color activeColor = AppColor.blueLight,
    EdgeInsets contentPadding = EdgeInsets.zero,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.leading,
  }) =>
      themeSelectBox(
        isCircle: isCircle,
        fillColor: fillColor,
        child: CheckboxListTile(
          title: title,
          subtitle: subtitle,
          secondary: secondary,
          activeColor: activeColor,
          contentPadding: contentPadding,
          controlAffinity: controlAffinity,
          value: value,
          onChanged: onChanged,
          dense: true,
        ),
      );
}
