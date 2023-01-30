import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_base/common/di/injector.dart';
import 'package:rxdart/rxdart.dart';

import '../../pages/pages.dart';
import 'screen_router.dart';

abstract class AppRouter {
  static AppRouter get to => AppInjector.injector<AppRouter>();

  /// stream listen and handle when user click button back in web
  static final PublishSubject listenBackPage = PublishSubject<ScreenRouter>();

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

  static GoRoute goRouteMain(
    ScreenRouter screenRouter, {
    List<GoRoute>? routes,
  }) {
    return GoRoute(
      name: screenRouter.name,
      path: screenRouter.path,
      pageBuilder: (context, state) {
        return MaterialPage<void>(
          key: ValueKey(ScreenRouter.main.name),
          child: MainPage(
            key: Key(screenRouter.name),
            initPageName: screenRouter,
          ),
        );
      },
      routes: routes ?? [],
    );
  }
}
