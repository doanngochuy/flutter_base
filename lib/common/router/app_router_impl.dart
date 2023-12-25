import 'package:EMO/common/router/router.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/pages/pages.dart';
import 'package:EMO/pages/withdraw/index.dart';
import 'package:go_router/go_router.dart';

const _noAuthRoutes = [
  ScreenRouter.signIn,
  ScreenRouter.signUp,
];

bool pathNotInAuthRoutes(Uri uri) => _noAuthRoutes.any((element) => element.path == uri.path);

class AppRouterImpl implements AppRouter {
  @override
  GoRouter get router => _router;

  final _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: ScreenRouter.home.path,
    redirect: (context, state) {
      final UserStore userStore = UserStore.to;

      /// if path = '/sign-in' or '/sign-up' and user is not sign in -> pass
      /// if user is not sign in -> signIn
      if (!userStore.isLogin.value && pathNotInAuthRoutes(state.uri)) return null;

      /// if user is not sign in -> signIn
      if (!userStore.isLogin.value) return ScreenRouter.signIn.path;

      /// if path = '/sign-in' or '/sign-up' and user is sign in -> home
      if (pathNotInAuthRoutes(state.uri)) return ScreenRouter.home.path;

      return null;
    },
    routes: [
      AppRouter.goRouteMain(
        ScreenRouter.main,
        routes: [
          AppRouter.goRoute(ScreenRouter.home, (state) => const TransactionPage()),
          AppRouter.goRoute(ScreenRouter.getJob, (state) => const GetJobPage()),
          AppRouter.goRoute(ScreenRouter.withdraw, (state) => const WithdrawPage()),
          AppRouter.goRoute(ScreenRouter.setting, (state) => const SettingPage()),
        ],
      ),
      AppRouter.goRoute(ScreenRouter.signIn, (state) => const SignInPage()),
    ],
    onException: (context, state, router) {
      return router.go(ScreenRouter.notFound.path, extra: state.uri.toString());
    },
    observers: [
      // Todo: Re implement this observer with code gen to prevent class name minification when release
      // AppNavigatorObserver(),
    ],
  );
}
