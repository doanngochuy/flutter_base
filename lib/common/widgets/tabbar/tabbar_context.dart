import 'package:flutter/material.dart';
import 'package:EMO/common/values/values.dart';

class CustomTabBarContext extends StatelessWidget {
  final int length;
  final Widget child;

  const CustomTabBarContext({
    required this.length,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      key: Key(AppKey.$tabBarContextKey),
      length: length,
      child: child,
    );
  }
}
