import 'package:flutter/material.dart';

import 'color.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.scaffoldBackground,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: AppColor.accentColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColor.accentColor,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: AppColor.primaryText,
      ),
      titleTextStyle: TextStyle(
        color: AppColor.primaryText,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      toolbarTextStyle: TextStyle(
        color: AppColor.primaryText,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColor.scaffoldBackground,
      unselectedLabelStyle: TextStyle(fontSize: 12),
      selectedLabelStyle: TextStyle(fontSize: 12),
      unselectedItemColor: Color(0xffA2A5B9),
      selectedItemColor: AppColor.accentColor,
    ),
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: AppColor.accentColor,
      unselectedLabelColor: AppColor.secondaryText,
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      checkColor: MaterialStateProperty.all(AppColor.blueLight),
      side: const BorderSide(width: 1, color: AppColor.blueLight),
      splashRadius: 0,
    ),
  );
}
