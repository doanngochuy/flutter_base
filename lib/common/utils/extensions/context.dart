import 'package:flutter/material.dart';

enum ContextPushTransitionType {
  simple,
  rightToLeft,
}

extension ContextExtensions on BuildContext {
  Future<T?> pushNavigator<T>(
    Widget widget, {
    bool fullscreenDialog = false,
    ContextPushTransitionType transitionType = ContextPushTransitionType.simple,
  }) async {
    PageRoute<T> pageRoute(ContextPushTransitionType transitionType) {
      switch (transitionType) {
        case ContextPushTransitionType.simple:
          return MaterialPageRoute(
            settings: RouteSettings(name: widget.runtimeType.toString()),
            fullscreenDialog: fullscreenDialog,
            builder: (context) => widget,
          );
        case ContextPushTransitionType.rightToLeft:
          return PageRouteBuilder<T>(
            settings: RouteSettings(name: widget.runtimeType.toString()),
            pageBuilder: (context, animation, secondaryAnimation) => widget,
            fullscreenDialog: fullscreenDialog,
            transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
              ),
              child: child,
            ),
          );
      }
    }

    return Navigator.push<T>(
      this,
      pageRoute(transitionType),
    );
  }

  void popNavigator<T extends Object?>([T? result]) => Navigator.pop(this, result);

  void popUntilNavigator<T extends Object?>(RoutePredicate predicate) =>
      Navigator.popUntil(this, predicate);

  void hideKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
