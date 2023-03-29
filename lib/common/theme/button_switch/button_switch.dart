import 'package:flutter/material.dart';
import 'package:EMO/common/theme/button_switch/button_switch_mulitchoice_builder.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';

part 'button_switch_builder.dart';

class CustomButtonSwitch {
  const CustomButtonSwitch._();

  static Widget buttonSwitch<T>({
    T? initState,
    required ButtonSwitchItem<T> item1,
    required ButtonSwitchItem<T> item2,
    required ValueChanged<T> onChanged,
    double? width,
    double? height,
    double? fontSize,
    double? borderRadius,
    EdgeInsets? paddingItem,
    Color? mainColor,
    TextStyle? textStyle,
  }) =>
      ButtonSwitchBuilder<T>(
        initState: initState,
        item1: item1,
        item2: item2,
        onChanged: onChanged,
        width: width,
        height: height,
        fontSize: fontSize,
        borderRadius: borderRadius,
        paddingItem: paddingItem,
        mainColor: mainColor,
        textStyle: textStyle,
      );

  static Widget buttonSwitchMultiChoice<T>({
    T? initState,
    required List<ButtonSwitchItem<T>> items,
    required ValueChanged<T> onChanged,
    required double width,
    double? borderRadius,
    EdgeInsets? paddingItem,
    Color? mainColor,
    TextStyle? textStyle,
  }) =>
      ButtonSwitchMultiBuilder<T>(
        initState: initState,
        items: items,
        onChanged: onChanged,
        width: width,
        borderRadius: borderRadius,
        paddingItem: paddingItem,
        mainColor: mainColor,
        textStyle: textStyle,
      );
}
