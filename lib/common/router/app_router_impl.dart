import 'package:flutter/material.dart';
import 'package:flutter_base/common/router/router.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/pages/pages.dart';
import 'package:go_router/go_router.dart';

class AppRouterImpl implements AppRouter {
  @override
  GoRouter get router => _router;

  final _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: ScreenRouter.main.path,
    redirect: (context, state) {
      final UserStore userStore = UserStore.to;

      if (!userStore.isLogin.value &&
          (state.location == ScreenRouter.signIn.path ||
              state.location == ScreenRouter.signUp.path)) return null;

      if (!userStore.isLogin.value) return ScreenRouter.signIn.path;

      if (state.location == ScreenRouter.signIn.path ||
          state.location == ScreenRouter.signUp.path) {
        return ScreenRouter.main.path;
      }

      return null;
    },
    routes: [
      AppRouter.goRouteMain(ScreenRouter.main),
      AppRouter.goRoute(ScreenRouter.signIn, (state) => const SignInPage()),
      AppRouter.goRoute(ScreenRouter.getJob, (state) => const GetJobPage()),

      AppRouter.goRouteMain(ScreenRouter.setting),
    ],
    errorPageBuilder: (context, state) =>
        MaterialPage(key: state.pageKey, child: const PageNotFound()),
    errorBuilder: (context, state) => const PageNotFound(),
  );
}
