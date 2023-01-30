import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/router/router.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/common/utils/utils.dart';
import 'package:flutter_base/common/values/values.dart';
import 'package:get/get.dart';

import '../../controller.dart';
import '../controller.dart';
import '../menu_model.dart';

class AppBarWebWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWebWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AppBarWebWidget> createState() => _AppBarWebWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWebWidgetState extends State<AppBarWebWidget> {
  final MainController _mainController = MainController.to;
  final MenuController _menuController = MenuController.to;

  Widget _menuItem(
    BuildContext context, {
    required MenuModel menuModel,
    required Color textColor,
    required bool haveChild,
    bool isSelected = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: Insets.xl),
      child: haveChild
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
            ),
    );
  }

  Widget _menuItemWithChild(
    BuildContext context, {
    required MenuModel menuModel,
    required bool isSelected,
    required List<MenuModel> menuModels,
    required Color textColor,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        iconEnabledColor: textColor,
        hint: Row(
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
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        style: TextStyles.title1.copyWith(
          color: AppColor.secondaryText,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          height: 0,
        ),
        items: menuModels.map<DropdownMenuItem<String>>(
          (MenuModel item) {
            final ScreenRouter currentPage = _mainController.state.currentPage;
            bool isSelected = item.screenRouter == currentPage;
            return DropdownMenuItem<String>(
              key: Key(AppKey.$appBarWebKey(item.key)),
              value: item.key,
              child: Row(
                children: <Widget>[
                  Icon(
                    item.icon,
                    size: IconSizes.med,
                    color: isSelected ? AppColor.blueLight : AppColor.secondaryText,
                  ),
                  HSpace.med,
                  Flexible(
                      child: Text(
                    item.title,
                    style: TextStyles.title1.copyWith(
                      color: isSelected ? AppColor.blueLight : AppColor.secondaryText,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
                ],
              ),
            );
          },
        ).toList(),
        onChanged: (value) {
          if (value == null) return;
          _menuController.handleRedirect(
              ScreenRouter.fromName(value) ?? ScreenRouter.main, context);
        },
        buttonHeight: 40.scaleSize,
        buttonWidth: menuModel.width,
        dropdownWidth: menuModels.map<double>((e) => e.width).toList().reduce(max),
        itemHeight: 40.scaleSize,
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
      key: Key(AppKey.$appBarWebKey(menuModel.key)),
      onTap: () => _menuController.handleRedirect(menuModel.screenRouter, context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
              fontWeight: FontWeight.normal,
              color: textColor,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.scaleSize,
      padding: EdgeInsets.symmetric(
        horizontal: Insets.lg,
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: Shadows.universal,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            $appName,
            style: TextStyles.h2,
          ),
          Expanded(
            child: Obx(
              () {
                final ScreenRouter currentPage = _mainController.state.currentPage;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _menuController.menuModels.map<Widget>(
                      (item) {
                        final MenuModel menuModel = item;
                        final bool haveChild = menuModel.children.isNotEmpty;
                        bool isSelected = currentPage == menuModel.screenRouter
                            ? true
                            : haveChild
                                ? menuModel.children.any((item) => item.screenRouter == currentPage)
                                : false;
                        final Color textColor =
                            isSelected ? AppColor.blueLight : AppColor.secondaryText;
                        return _menuItem(
                          context,
                          textColor: textColor,
                          haveChild: haveChild,
                          menuModel: menuModel,
                          isSelected: isSelected,
                        );
                      },
                    ).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
