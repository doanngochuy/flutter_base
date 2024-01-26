import 'package:get/get.dart';
import 'package:EMO/common/router/router.dart';

class MainState {
  final _currentPage = Rx(ScreenRouter.main);

  ScreenRouter get currentPage => _currentPage.value;

  void setCurrentPage(ScreenRouter? screenRouter) {
    if (screenRouter != null) {
      _currentPage.value = screenRouter;
    }
  }
}
