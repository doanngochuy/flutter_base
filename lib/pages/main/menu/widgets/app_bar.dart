import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/values/keys.dart';

import '../controller.dart';

class CustomAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final Widget customAppBar;

  const CustomAppBarWidget({
    Key? key,
    required this.customAppBar,
  }) : super(key: key);

  @override
  State<CustomAppBarWidget> createState() => _CustomAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      leading: IconButton(
        key: Key(AppKey.$showDrawerKey),
        icon: const Icon(Icons.menu),
        onPressed: MenuController.to.keyDrawer.currentState?.openDrawer,
      ),
      titleSpacing: 0,
      backgroundColor: AppColor.white,
      title: widget.customAppBar,
      centerTitle: false,
    );
  }
}
