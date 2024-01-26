import 'package:EMO/common/router/router.dart';
import 'package:flutter/material.dart';

class MenuModel {
  ScreenRouter? screenRouter;
  IconData icon;
  final String? _title;
  final String? _key;

  String get title => _title ?? screenRouter?.title ?? '';

  String get key => _key ?? screenRouter?.name ?? '';

  MenuModel({
    this.screenRouter,
    String? title,
    String? key,
    required this.icon,
  })  : _title = title,
        _key = key;
}
