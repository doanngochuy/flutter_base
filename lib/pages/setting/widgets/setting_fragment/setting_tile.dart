import 'package:flutter/material.dart';
import 'package:EMO/common/styles/styles.dart';

class SettingTileWidget<T> extends StatelessWidget {
  final List<Widget> children;
  final bool fullHeight;

  const SettingTileWidget({
    required this.children,
    this.fullHeight = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fullHeight ? MediaQuery.of(context).size.height : null,
      decoration: const BoxDecoration(color: AppColor.white, borderRadius: Corners.medBorder),
      child: Column(
        children: children,
      ),
    );
  }
}
