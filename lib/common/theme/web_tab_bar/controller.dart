import 'package:get/get.dart';

class WebTabBarController extends GetxController {
  static WebTabBarController get to => Get.find<WebTabBarController>();

  final Rx<bool> _isHidden = Rx<bool>(false);

  get isHidden => _isHidden.value;

  void openTabBar(){
    _isHidden.value = false;
  }

  void hiddenTabBar(){
    _isHidden.value = true;
  }

  void toggleTabBar(){
    _isHidden.value = !_isHidden.value;
  }
}