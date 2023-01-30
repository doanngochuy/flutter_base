import 'package:flutter_base/common/utils/utils.dart';

enum ScreenWidth {
  MOBILE,
  TABLET,
  DESKTOP,
}

class Screen {
  static const double _desktop = 1200;
  static const double _tablet = 650;
  static const double _mobile = 300;

  static double get widthDesktop => _desktop;
  static double get widthTablet => _tablet;
  static double get widthMobile => _mobile;

  static ScreenWidth getCurrentScreen(double width) {
    if(width > _desktop) {
      if (isWeb) return ScreenWidth.DESKTOP;
      return ScreenWidth.TABLET;
    } else if(width > _tablet){
      return ScreenWidth.TABLET;
    }
    return ScreenWidth.MOBILE;
  }
}