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

      /// if path = '/sign-in' or '/sign-up' and user is not sign in -> pass
      /// if user is not sign in -> signIn
      if (!userStore.isLogin.value &&
          (state.location == ScreenRouter.signIn.path ||
              state.location == ScreenRouter.signUp.path)) return null;

      if (!userStore.isLogin.value) return ScreenRouter.signIn.path;

      /// if path = '/sign-in' or '/sign-up' and user is sign in -> home
      if (state.location == ScreenRouter.signIn.path ||
          state.location == ScreenRouter.signUp.path) {
        return ScreenRouter.main.path;
      }

      /// add data to sink stream when user change path
      /// eg: user click button back in web: stream will add data path(state.location)
      final ScreenRouter? screenRouter = ScreenRouter.fromPath(state.location);

      if (ScreenRouter.fromPath(state.location) != null) {
        AppRouter.listenBackPage.sink.add(screenRouter);
      }

      /// all exception pass
      return null;
    },
    routes: [
      AppRouter.goRouteMain(ScreenRouter.main),
      AppRouter.goRoute(ScreenRouter.signIn, (state) => const SignInPage()),
      AppRouter.goRouteMain(ScreenRouter.setting),
    ],
    errorPageBuilder: (context, state) =>
        MaterialPage(key: state.pageKey, child: const PageNotFound()),
    errorBuilder: (context, state) => const PageNotFound(),
  );
}
