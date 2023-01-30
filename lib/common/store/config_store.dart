import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter_base/common/config/config.dart';
import 'package:flutter_base/common/di/injector.dart';
import 'package:flutter_base/common/local/prefs/prefs_sevice.dart';
import 'package:flutter_base/common/models/models.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/values/values.dart';

class ConfigStore {
  static ConfigStore get to => AppInjector.injector<ConfigStore>();

  ConfigStore() {
    isFirstOpen = PrefsService.to.getBool(AppStorage.storageDeviceFirstOpen);
  }

  /// Version
  bool isFirstOpen = false;
  PackageInfo? _platform;

  String get version => _platform?.version ?? '-';

  bool get isRelease => const bool.fromEnvironment("dart.vm.product_item");

  /// Locale
  static const List<Locale> languages = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
  ];
  Locale locale = const Locale('vi', 'VN');

  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }

  Future<bool> saveAlreadyOpen() {
    return PrefsService.to.setBool(AppStorage.storageDeviceFirstOpen, false);
  }

  void onInitLocale() {
    var langCode = PrefsService.to.getString(AppStorage.storageLanguage);
    if (langCode.isEmpty) return;
    var index = languages.indexWhere((element) {
      return element.languageCode == langCode;
    });
    if (index < 0) return;
    locale = languages[index];
  }

  void onLocaleUpdate(Locale value) {
    locale = value;
    Get.updateLocale(value);
    PrefsService.to.setString(AppStorage.storageLanguage, value.languageCode);
  }

  Locale? onLocaleCurrent() {
    var langCode = PrefsService.to.getString(AppStorage.storageLanguage);
    if (langCode.isEmpty) return null;
    var index = languages.indexWhere((element) {
      return element.languageCode == langCode;
    });
    if (index < 0) return null;
    return languages[index];
  }

  /// Responsive: Text scale & Screen width
  static const List<double> _scales = [1, 1.05, 1.1];
  double scale = _scales[0];

  double deviceWidth = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

  double deviceHeight = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;

  ScreenWidth screenWidth = ScreenWidth.DESKTOP;

  void onChangeScreen(double width) {
    final ScreenWidth oldScreenWidth = screenWidth;
    screenWidth = Screen.getCurrentScreen(width);
    deviceWidth = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    deviceHeight = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    if (oldScreenWidth != screenWidth) {
      switch (screenWidth) {
        case ScreenWidth.DESKTOP:
          scale = _scales[2];
          break;
        case ScreenWidth.TABLET:
          scale = _scales[1];
          break;
        default:
          scale = _scales[0];
      }
      Sizes.setHitScale(scale);
      IconSizes.setScale(scale);
      Insets.setScale(scale);
      FontSizes.setScale(scale);
      Height.setScale(scale);
    }
  }

  /// Type Login
  TypeLogin? _typeLogin;

  TypeLogin? get typeLogin =>
      _typeLogin ?? TypeLogin.fromString(PrefsService.to.getString(AppStorage.storageTypeLogin));

  void setTypeLogin(TypeLogin? roleLogin) {
    _typeLogin = roleLogin;
    PrefsService.to.setString(AppStorage.storageTypeLogin, roleLogin?.name ?? '');
  }
}
