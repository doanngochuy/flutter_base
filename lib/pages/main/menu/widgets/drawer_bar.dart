import 'package:flutter/material.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/router/router.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:EMO/common/values/values.dart';
import 'package:EMO/pages/main/index.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class DrawerBarWidget extends StatelessWidget {
  DrawerBarWidget({Key? key}) : super(key: key);

  final MainController _mainController = MainController.to;
  final MenuXController _menuController = MenuXController.to;

  Widget _menuItem(
    BuildContext context, {
    required MenuModel menuModel,
    required Color textColor,
    required bool haveChild,
    bool isSelected = false,
  }) {
    return haveChild
        ? _menuItemWithChild(
            context,
            menuModel: menuModel,
            isSelected: isSelected,
            menuModels: menuModel.children,
            textColor: textColor,
          )
        : _singleMenuItem(
            context,
            menuModel: menuModel,
            isSelected: isSelected,
            textColor: textColor,
          );
  }

  Widget _menuItemWithChild(
    BuildContext context, {
    required MenuModel menuModel,
    required bool isSelected,
    required List<MenuModel> menuModels,
    required Color textColor,
  }) {
    final ScreenRouter currentPage = _mainController.state.currentPage;
    final List<Widget> menuModelChild = [];
    for (int index = 0; index < menuModels.length; index++) {
      final bool subIsSelected = currentPage == menuModels[index].screenRouter;
      final Color subTextColor = subIsSelected ? AppColor.blueLight : AppColor.black800;
      menuModelChild.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Insets.med),
          child: _singleMenuItem(
            context,
            menuModel: menuModels[index],
            textColor: subTextColor,
            isSelected: subIsSelected,
          ),
        ),
      );
    }
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        key: Key(AppKey.$expansionKey(menuModel.key)),
        backgroundColor: Colors.transparent,
        title: Row(
          children: <Widget>[
            Icon(
              menuModel.icon,
              size: IconSizes.med,
              color: textColor,
            ),
            HSpace.sm,
            Text(
              menuModel.title,
              style: TextStyles.title1.copyWith(
                color: textColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            )
          ],
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: EdgeInsets.zero,
        tilePadding: EdgeInsets.symmetric(
          horizontal: Insets.sm,
          vertical: 0,
        ),
        iconColor: textColor,
        collapsedIconColor: textColor,
        collapsedTextColor: textColor,
        initiallyExpanded: isSelected,
        children: menuModelChild,
      ),
    );
  }

  Widget _singleMenuItem(
    BuildContext context, {
    required MenuModel menuModel,
    required bool isSelected,
    required Color textColor,
  }) {
    return InkWell(
      key: Key(AppKey.$drawerBarKey(menuModel.key)),
      onTap: () => _menuController.handleRedirect(menuModel.screenRouter, context),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
          horizontal: Insets.sm,
          vertical: 17.scaleSize,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              menuModel.icon,
              size: IconSizes.med,
              color: textColor,
            ),
            HSpace.sm,
            Text(
              menuModel.title,
              style: TextStyles.title1.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: textColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.blueLight,
                  AppColor.accentColor,
                ],
              ),
            ),
            curve: Curves.easeInOut,
            margin: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: context.width,
                  child: Text(
                    $appName,
                    style: TextStyles.h1.copyWith(color: AppColor.white),
                  ),
                ),
                CustomButton.fullColor(
                  onPressed: () {
                    _menuController.logout().then((_) {
                      context.goNamed(ScreenRouter.signIn.name);
                    });
                  },
                  background: AppColor.scaffoldBackground,
                  textColor: AppColor.black800,
                  radius: Corners.lg,
                  text: S.current.Dang_xuat,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(Insets.sm),
              separatorBuilder: (_, index) {
                return const Divider();
              },
              itemCount: _menuController.menuModels.length,
              itemBuilder: (context, index) {
                final ScreenRouter currentPage = _mainController.state.currentPage;
                final MenuModel menuModel = _menuController.menuModels[index];
                final bool haveChild = menuModel.children.isNotEmpty;
                bool isSelected = currentPage == menuModel.screenRouter ||
                    (haveChild &&
                        menuModel.children.any((item) => item.screenRouter == currentPage));
                final Color textColor = isSelected ? AppColor.blueLight : AppColor.black800;
                return _menuItem(
                  context,
                  textColor: textColor,
                  haveChild: haveChild,
                  menuModel: menuModel,
                  isSelected: isSelected,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
