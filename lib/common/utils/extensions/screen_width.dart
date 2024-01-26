import 'package:EMO/common/config/config.dart';
import 'package:EMO/common/utils/extensions/platform.dart';


extension ScreenWidthExtension on ScreenWidth {
  bool get isTablet => ScreenWidth.tablet == this;

  bool get isMobile => ScreenWidth.mobile == this;

  bool get isDesktop => ScreenWidth.desktop == this && isWeb;
}
