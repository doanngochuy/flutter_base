import 'package:flutter/material.dart';
import 'package:EMO/common/di/injector.dart';
import 'package:go_router/go_router.dart';

import '../../pages/pages.dart';
import 'screen_router.dart';

abstract class AppRouter {
  static AppRouter get to => AppInjector.injector<AppRouter>();

  GoRouter get router;

  static GoRoute goRoute(
    ScreenRouter screenRouter,
    Widget Function(GoRouterState state) pageBuilder, {
    List<GoRoute>? routes,
  }) {
    return GoRoute(
      name: screenRouter.name,
      path: screenRouter.path,
      pageBuilder: (context, state) => MaterialPage<void>(
        key: ValueKey(screenRouter.name),
        child: pageBuilder(state),
      ),
      routes: routes ?? [],
    );
  }

  static ShellRoute goRouteMain(
    ScreenRouter screenRouter, {
    List<GoRoute>? routes,
  }) {
    final shellNavigatorKey = GlobalKey<NavigatorState>();
    return ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) => MainPage(child: child),
      routes: routes ?? [],
    );
  }
}
