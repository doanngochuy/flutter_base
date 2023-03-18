import 'package:flutter/material.dart';
import 'package:flutter_base/common/router/router.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/pages/pages.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class MenuController extends GetxController {
  static MenuController get to => Get.find<MenuController>();

  final GlobalKey<ScaffoldState> keyDrawer = GlobalKey();

  late final List<MenuModel> menuModels;

  @override
  void onInit() {
    super.onInit();
    menuModels = [
      MenuModel(
        screenRouter: ScreenRouter.getJob,
        icon: Icons.money,
      ),
      MenuModel(
        screenRouter: ScreenRouter.setting,
        icon: Icons.settings_outlined,
      ),
      MenuModel(
        screenRouter: ScreenRouter.test,
        icon: Icons.transfer_within_a_station_outlined,
      ),
    ];
  }

  void handleRedirect(ScreenRouter? screenRouter, BuildContext context) {
    keyDrawer.currentState?.closeDrawer();
    if (screenRouter != null && MainController.to.state.currentPage != screenRouter) {
      context.go(screenRouter.path);
      MainController.to.state.setCurrentPage(screenRouter);
    }
  }

  Future<void> logout() => Loading.openAndDismissLoading(() => UserStore.to.onLogout());
}
