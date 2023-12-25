import 'dart:math';

import 'package:EMO/common/styles/styles.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'controller.dart';
import 'menu_model.dart';

class BottomNavigationBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const BottomNavigationBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  final MenuXController _menuController = MenuXController.to;

  int get _currentIndex => _locationToTabIndex(GoRouterState.of(context).fullPath ?? '');

  List<BottomNavigationBarItem> get tabs =>
      _menuController.menuModels.map((e) => _singleMenuItem(context, menuModel: e)).toList();

  int _locationToTabIndex(String location) {
    final index = _menuController.menuModels
        .indexWhere((t) => location.startsWith(t.screenRouter?.path ?? '###'));
    return max(0, index);
  }

  BottomNavigationBarItem _singleMenuItem(
    BuildContext context, {
    required MenuModel menuModel,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(
        menuModel.icon,
        size: IconSizes.mid,
      ),
      label: menuModel.title,
    );
  }

  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      context.go(_menuController.menuModels[tabIndex].screenRouter?.path ?? '###');
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedBottomNavigationBar.builder(
        backgroundColor: Colors.white,
        splashColor: AppColor.primary,
        borderColor: Colors.grey[200],
        activeIndex: _currentIndex,
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: (index) => _onItemTapped(context, index),
        itemCount: _menuController.menuModels.map((e) => e.icon).length,
        gapLocation: GapLocation.none,
        tabBuilder: (int index, bool isActive) => Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _menuController.menuModels.elementAtOrNull(index)?.icon ?? Icons.home,
              color: isActive ? AppColor.primary : AppColor.grey600,
              size: 22,
            ),
            const SizedBox(height: 2),
            Text(
              _menuController.menuModels.elementAtOrNull(index)?.title ?? '',
              style: TextStyle(
                color: isActive ? AppColor.primary : AppColor.grey600,
                fontSize: 12,
              ),
            )
          ],
        ),
      );
}
