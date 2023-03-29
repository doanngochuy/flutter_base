import 'package:EMO/common/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controller.dart';
import '../menu_model.dart';

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

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  List<BottomNavigationBarItem> get tabs =>
      _menuController.menuModels.map((e) => _singleMenuItem(context, menuModel: e)).toList();

  int _locationToTabIndex(String location) {
    final index = _menuController.menuModels
        .indexWhere((t) => location.startsWith(t.screenRouter?.path ?? '###'));
    return index < 0 ? 0 : index;
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
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColor.successColor,
      items: tabs,
      currentIndex: _currentIndex,
      onTap: (index) => _onItemTapped(context, index),
    );
  }
}
