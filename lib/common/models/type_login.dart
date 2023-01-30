import 'package:collection/collection.dart';

enum TypeLogin {
  cashiers,
  order,
  selfOrder,
  kitchen;

  static TypeLogin? fromString(dynamic json) {
    if (json == null) return null;
    return TypeLogin.values.firstWhereOrNull(
      (e) => e.name == json,
    );
  }
}
