import 'package:flutter/material.dart';
import 'package:flutter_base/common/values/values.dart';

class CustomTabBarView extends StatelessWidget {
  final TabController? controller;
  final List<Widget> children;
  final ScrollPhysics? physics;

  const CustomTabBarView({
    required this.children,
    this.controller,
    this.physics,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      key: Key(AppKey.$tabBarViewKey),
      controller: controller ?? DefaultTabController.of(context)!,
      children: children,
    );
  }
}
