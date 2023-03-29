import 'package:EMO/common/config/config.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:EMO/pages/main/menu/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    Get.put(MenuXController());
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
      key: MenuXController.to.keyDrawer,
      drawer: DrawerBarWidget(),
      body: widget.appBody,
    );
  }

  Widget appBarForMobile() {
    return Container(
      color: AppColor.successColor,
      child: SafeArea(
      left: false,
      right: false,
      bottom: false,
      child: Scaffold(
        key: MenuXController.to.keyDrawer,
        bottomNavigationBar: const BottomNavigationBarWidget(),
        body: widget.appBody,
      ),
        ),
    );
  }

  Widget renderAppBar() {
    if (isWeb) {
      switch (ConfigStore.to.screenWidth) {
        case ScreenWidth.DESKTOP:
          return appBarForWeb();
        case ScreenWidth.MOBILE:
          return appBarForMobile();
        case ScreenWidth.TABLET:
          return appBarForApp();
      }
    }
    return appBarForMobile();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) => renderAppBar(),
    );
  }
}
