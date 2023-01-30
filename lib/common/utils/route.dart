import 'package:flutter/material.dart';

class CompareRoute {
  CompareRoute._();

  static RoutePredicate withType(Type name) => (Route<dynamic> route) =>
      !route.willHandlePopInternally && route.settings.name == name.toString();
}
