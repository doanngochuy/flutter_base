import 'package:flutter/material.dart';
import 'package:flutter_base/common/router/router.dart';

class MenuModel {
  ScreenRouter? screenRouter;
  IconData icon;
  double width;
  List<MenuModel> children;
  final String? _title;
  final String? _key;

  String get title => _title ?? screenRouter?.title ?? '';

  String get key => _key ?? screenRouter?.name ?? '';

  /// [title] Show in Drawer or Appbar. If null then equal [screenRouter.title]
  ///
  /// [key] For testing. If null then equal [screenRouter.name]
  ///
  MenuModel({
    this.screenRouter,
    String? title,
    String? key,
    required this.icon,
    this.width = 160,
    this.children = const [],
  })  : _title = title,
        _key = key;
}

enum MenuStyle { drawer, toolbar }
