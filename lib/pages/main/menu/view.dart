import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_base/common/config/config.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/utils/utils.dart';
import 'package:flutter_base/pages/main/menu/index.dart';

class CustomMenuBar extends StatefulWidget {
  const CustomMenuBar({
    Key? key,
    required this.appBody,
    this.customNavBar = const SizedBox(),
  }) : super(key: key);

  final Widget appBody;
  final Widget customNavBar;

  @override
  State<CustomMenuBar> createState() => _CustomMenuBarState();
}

class _CustomMenuBarState extends State<CustomMenuBar> {
  @override
  void initState() {
    super.initState();
    Get.put(MenuController());
  }

  Widget appBarForWeb() {
    return SafeArea(
      minimum: EdgeInsets.only(top: Insets.med),
      child: Scaffold(
        appBar: const AppBarWebWidget(),
        resizeToAvoidBottomInset: true,
        body: widget.appBody,
      ),
    );
  }

  Widget appBarForApp() {
    return Scaffold(
      appBar: CustomAppBarWidget(
        customAppBar: widget.customNavBar,
      ),
      key: MenuController.to.keyDrawer,
      drawer: DrawerBarWidget(),
      body: widget.appBody,
    );
  }

  Widget renderAppBar() {
    if (isWeb) {
      switch (ConfigStore.to.screenWidth) {
        case ScreenWidth.DESKTOP:
          return appBarForWeb();
        case ScreenWidth.MOBILE:
        case ScreenWidth.TABLET:
          return appBarForApp();
      }
    }
    return appBarForApp();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) => renderAppBar(),
    );
  }
}
