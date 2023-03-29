import 'package:EMO/pages/withdraw/index.dart';
import 'package:flutter/material.dart';
import 'package:EMO/common/router/router.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/pages/pages.dart';
import 'package:go_router/go_router.dart';

class AppRouterImpl implements AppRouter {
  @override
  GoRouter get router => _router;

  final _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: "/job-done",
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
      AppRouter.goRouteMain(ScreenRouter.main,
          routes: [
            AppRouter.goRoute(ScreenRouter.jobDone, (state) => const JobDonePage()),
            AppRouter.goRoute(ScreenRouter.getJob, (state) => const GetJobPage()),
            AppRouter.goRoute(ScreenRouter.withdraw, (state) => const WithdrawPage()),
            AppRouter.goRoute(ScreenRouter.setting, (state) => const SettingPage()),
          ],
      ),
      AppRouter.goRoute(ScreenRouter.signIn, (state) => const SignInPage()),
    ],
    errorPageBuilder: (context, state) =>
        MaterialPage(key: state.pageKey, child: const PageNotFound()),
    errorBuilder: (context, state) => const PageNotFound(),
  );
}
