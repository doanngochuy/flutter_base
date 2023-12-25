import 'package:EMO/common/router/router.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuXController extends GetxController {
  static MenuXController get to => Get.find<MenuXController>();

  final GlobalKey<ScaffoldState> keyDrawer = GlobalKey();

  final List<MenuModel> menuModels = [
    MenuModel(
      screenRouter: ScreenRouter.home,
      icon: FontAwesomeIcons.houseChimney,
    ),
    MenuModel(
      screenRouter: ScreenRouter.getJob,
      icon: FontAwesomeIcons.briefcase,
    ),
    MenuModel(
      screenRouter: ScreenRouter.withdraw,
      icon: FontAwesomeIcons.wallet,
    ),
    MenuModel(
      screenRouter: ScreenRouter.setting,
      icon: FontAwesomeIcons.gear,
    ),
  ];

  void handleRedirect(ScreenRouter? screenRouter, BuildContext context) {
    keyDrawer.currentState?.closeDrawer();
    if (screenRouter != null && MainController.to.state.currentPage != screenRouter) {
      context.go(screenRouter.path);
      MainController.to.state.setCurrentPage(screenRouter);
    }
  }

  Future<void> logout() => Loading.openAndDismissLoading(() => UserStore.to.onLogout());
}
