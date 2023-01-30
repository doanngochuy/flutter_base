import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';

class SettingTitleWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;

  const SettingTitleWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: TextStyles.h3),
      leading: Icon(icon),
      trailing: trailing,
    );
  }
}
