import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_base/common/router/router.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/utils/utils.dart';
import 'package:flutter_base/pages/pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
    required this.initPageName,
  }) : super(key: key);

  final ScreenRouter initPageName;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainController controller = Get.put(MainController());
  late final StreamSubscription streamSubscription; // listen page
  late final StreamSubscription streamSubscription2; // listen login

  @override
  void initState() {
    super.initState();
    streamSubscription = AppRouter.listenBackPage.stream
        .map((event) => event as ScreenRouter?)
        .listen(controller.state.setCurrentPage);
    if (isMobile) {
      streamSubscription2 = UserStore.to.isLogin.listen((event) {
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
    streamSubscription.cancel();
    if (isMobile) {
      streamSubscription2.cancel();
    }
    controller.disposeService();
  }

  late Widget customNavBar;
  ScreenRouter? pageCustomNavBar;

  /// need to know exactly what do the page call this function
  /// when another page call this function or not, it will reload name of page on navbar
  void setCustomNavBar(Widget navBar, ScreenRouter fromPage) {
    setState(() {
      customNavBar = navBar;
      pageCustomNavBar = fromPage;
    });
  }

  /// if page don't need to use custom navbar, it can return simple name of page
  Widget getCustomNavBar() {
    return Obx(() {
      if (controller.state.currentPage == pageCustomNavBar) {
        return customNavBar;
      }
      return Text(
        MainController.to.state.currentPage.title,
        style: TextStyles.title1,
      );
    });
  }

  /// if you want to add new page to menu -> take 4 steps
  /// step 1: create ScreenRouter into file in folder router (attention read the documents)
  /// step 2: create Router into file app_router (attention read the documents)
  /// step 3: add new menu model to list menu model into file controller of menu (attention read the documents)
  /// step 4: add Widget of page into function renderPage below
  Widget renderPage() {
    return Obx(
      () {
        switch (controller.state.currentPage) {
          case ScreenRouter.main:
            return Container();
          case ScreenRouter.setting:
            return const SettingPage();
          default:
            return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomMenuBar(
      appBody: renderPage(),
      customNavBar: getCustomNavBar(),
    );
  }
}
