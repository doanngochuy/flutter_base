import 'package:flutter/material.dart';

class WebTabBarItem {
  final String title;
  final IconData iconWhenHide;
  final bool isFiltering;
  final VoidCallback onTapWhenHide;
  final Widget childWhenOpen;

  WebTabBarItem({
    required this.title,
    required this.iconWhenHide,
    required this.isFiltering,
    required this.onTapWhenHide,
    required this.childWhenOpen,
  });
}
