import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';

class SettingNavigatorWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? subtitle;
  final VoidCallback? onTap;
  final IconData? leadingIcon;
  final Color? selectedColor;
  final Color? backgroundColor;
  final bool selected;
  final Color? iconColor;
  final double? iconSize;

  const SettingNavigatorWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    this.leadingIcon,
    this.backgroundColor,
    this.selectedColor,
    this.selected = false,
    this.iconColor,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      selectedColor: selectedColor,
      selectedTileColor: backgroundColor,
      leading: leadingIcon != null ? Icon(leadingIcon) : null,
      title: Text(
        title,
        style: TextStyles.title1.copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: Insets.med),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: Icon(
        icon,
        color: iconColor ?? AppColor.black800,
        size: iconSize ?? IconSizes.sm,
      ),
      onTap: onTap,
    );
  }
}
