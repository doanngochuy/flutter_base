import 'package:flutter_base/common/config/config.dart';
import 'package:flutter_base/common/utils/extensions/platform.dart';


extension ScreenWidthExtension on ScreenWidth {
  bool get isTablet => ScreenWidth.TABLET == this;

  bool get isMobile => ScreenWidth.MOBILE == this;

  bool get isDesktop => ScreenWidth.DESKTOP == this && isWeb;
}
