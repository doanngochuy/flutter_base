import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';

DropdownMenuItem dropdownItem<T>(T value, String name) => DropdownMenuItem<T>(
      value: value,
      child: Text(
        name,
        style: TextStyles.title1.copyWith(
          color: AppColor.black800,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
