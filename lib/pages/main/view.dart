import 'dart:async';

import 'package:EMO/common/router/router.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:EMO/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'menu/bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final ScreenRouter initPageName = ScreenRouter.main;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainController controller = Get.put(MainController());
  final _menuController = Get.put(MenuXController());
  late final StreamSubscription streamSubscription; // listen login

  @override
  void initState() {
    super.initState();
    if (isMobile) {
      streamSubscription = UserStore.to.isLogin.listen((event) {
        if (!event) {
          context.goNamed(ScreenRouter.signIn.name);
        }
      });
    }
    controller.initMain(widget.initPageName);
  }

  @override
  void dispose() {
    super.dispose();
    if (isMobile) {
      streamSubscription.cancel();
    }
    controller.disposeService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primary,
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          key: _menuController.keyDrawer,
          bottomNavigationBar: const BottomNavigationBarWidget(),
          body: widget.child,
        ),
      ),
    );
  }
}
