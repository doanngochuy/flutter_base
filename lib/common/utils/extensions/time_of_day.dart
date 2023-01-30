import 'package:flutter/material.dart';

extension TimeOfDayOrNullExtension on TimeOfDay? {
  /// 2022-07-12T09:37:01.2830000Z ---> 37:01
  String get timeToStr {
    if (this != null) {
      return '${this!.hour.toString().padLeft(2, '0')}:${this!.minute.toString().padLeft(2, '0')}';
    }
    return 'HH:mm';
  }
}