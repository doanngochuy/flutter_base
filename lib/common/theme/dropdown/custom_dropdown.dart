import 'package:flutter/material.dart';

import '../theme.dart';

Widget customDropdownMenu({
  required String name,
  required String label,
  required List<DropdownMenuItem> items,
  bool enabled = true,
  double? width,
  double? height,
  int initialValue = 0,
  Function(dynamic)? onChanged,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CustomInput.dropdownOutline(
        width: width,
        height: height,
        name: name,
        key: UniqueKey(),
        enabled: enabled,
        onChanged: onChanged,
        hintText: label,
        labelText: label,
        initialValue: initialValue,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        items: items,
      ),
    );