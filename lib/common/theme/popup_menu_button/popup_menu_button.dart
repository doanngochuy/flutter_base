import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/utils/extensions/extensions.dart';

class PopupMenuButtonItem<T> {
  final IconData? icon;
  final String text;
  final T value;

  const PopupMenuButtonItem({
    this.icon,
    required this.text,
    required this.value,
  });
}

class CustomPopupMenuButton {
  const CustomPopupMenuButton._();

  static Widget _basePopupMenuButton<T>({
    Icon? icon,
    Widget? child,
    required List<PopupMenuEntry<T>> items,
    required PopupMenuItemSelected<T> onSelected,
    Offset offset = Offset.zero,
    EdgeInsets? padding,
  }) {
    return PopupMenuButton<T>(
      icon: icon,
      offset: offset,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => items,
      shape: const RoundedRectangleBorder(
        borderRadius: Corners.medBorder,
      ),
      padding: padding ?? EdgeInsets.all(Insets.sm),
      child: child,
    );
  }

  static PopupMenuItem<T> _basePopupMenuItem<T>({
    required PopupMenuButtonItem<T> item,
    bool iconIsRight = false,
    Color iconItemColor = AppColor.black800,
    double? iconItemSize,
    TextStyle? style,
  }) {
    return PopupMenuItem<T>(
      value: item.value,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        minLeadingWidth: 0,
        horizontalTitleGap: Insets.med,
        leading: item.icon != null
            ? !iconIsRight
                ? Icon(
                    item.icon,
                    color: iconItemColor,
                    size: iconItemSize ?? 26.scaleSize,
                  )
                : null
            : null,
        trailing: item.icon != null
            ? iconIsRight
                ? Icon(
                    item.icon,
                    color: iconItemColor,
                    size: iconItemSize ?? 26.scaleSize,
                  )
                : null
            : null,
        title: Text(
          item.text,
          style: style ??
              TextStyles.title2.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
    );
  }

  static Widget popupMenuButton<T>({
    Icon? icon,
    Widget? child,
    required PopupMenuItemSelected<T> onSelected,
    required List<PopupMenuButtonItem<T>> items,
    List<PopupMenuButtonItem<T>>? sectioned,
    Offset offset = Offset.zero,
    bool iconIsRight = false,
    Color iconItemColor = AppColor.black800,
    double? iconItemSize,
    TextStyle? style,
    EdgeInsets? padding,
  }) {
    final List<PopupMenuEntry<T>> menuItems = [];
    if (sectioned != null && sectioned.isNotEmpty) {
      for (var item in sectioned) {
        menuItems.add(
          _basePopupMenuItem<T>(
            item: item,
            iconIsRight: iconIsRight,
            iconItemColor: iconItemColor,
            iconItemSize: iconItemSize,
            style: style,
          ),
        );
      }
      menuItems.add(
        PopupMenuDivider(
          height: 2.scaleSize,
        ),
      );
    }
    for (var item in items) {
      menuItems.add(
        _basePopupMenuItem<T>(
          item: item,
          iconIsRight: iconIsRight,
          iconItemColor: iconItemColor,
          iconItemSize: iconItemSize,
          style: style,
        ),
      );
    }
    return _basePopupMenuButton<T>(
      icon: icon,
      child: child,
      padding: padding,
      onSelected: onSelected,
      offset: offset,
      items: menuItems,
    );
  }
}
