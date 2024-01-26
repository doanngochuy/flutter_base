import 'dart:convert';

import 'package:EMO/common/utils/utils.dart';

class ValueReader {
  ValueReader._();

  static T? _maybeString<T>(Map json, String key) {
    final value = json[key];

    if (value is String) {
      switch (T) {
        case String:
          return value as T;
        case int:
          return value.parseSafeInt as T;
        case double:
          return value.parseSafeDouble as T;
        case bool:
          return (value == 'true') as T;
        case List:
          return value.isNotEmpty ? jsonDecode(value) : const [] as T;
        default:
          throw UnsupportedError('Unsupported type $T');
      }
    }

    switch (T) {
      case int:
        return (value as num?)?.toInt() as T?;
      case double:
        return (value as num?)?.toDouble() as T?;
      case bool:
        return (value == 'true') as T;
    }

    return value as T?;
  }

  static int? intMaybeString(Map json, String key) => _maybeString<int>(json, key);

  static double? doubleMaybeString(Map json, String key) => _maybeString<double>(json, key);

  static List<dynamic>? listMaybeString(Map json, String key) =>
      _maybeString<List<dynamic>>(json, key);
}
