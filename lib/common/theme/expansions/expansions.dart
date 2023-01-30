import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';

import '../cards/cards.dart';

class CustomExpansion {
  const CustomExpansion._();

  static Widget expansion(
    BuildContext context, {
    required List<Widget> children,
    Color backgroundColor = AppColor.white,
    String? title,
    Widget? customTitle,
    Widget? leading,
    Widget? trailing,
    CrossAxisAlignment expandedCrossAxisAlignment = CrossAxisAlignment.start,
    EdgeInsetsGeometry? childrenPadding,
    Color? collapsedIconColor,
    Color? iconColor,
    Color? collapsedTextColor,
    List<BoxShadow>? boxShadow,
  }) {
    return CustomCard.card1(
      boxShadow: boxShadow,
      borderRadius: Corners.medBorder,
      color: backgroundColor,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: customTitle ??
              Text(
                title ?? '',
                style: TextStyles.title2.copyWith(
                  color: AppColor.black800,
                ),
              ),
          leading: leading,
          trailing: trailing,
          expandedCrossAxisAlignment: expandedCrossAxisAlignment,
          childrenPadding: childrenPadding ?? EdgeInsets.all(Insets.med),
          collapsedTextColor: collapsedTextColor ?? AppColor.black800,
          collapsedIconColor: collapsedIconColor ?? AppColor.black800,
          iconColor: iconColor ?? AppColor.black800,
          children: children,
        ),
      ),
    );
  }
}
