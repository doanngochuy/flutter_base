import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppRefresher extends StatelessWidget {
  const AppRefresher({
    required this.controller,
    this.child,
    this.onRefresh,
    this.onLoading,
    this.onTwoLevel,
    this.dragStartBehavior,
    this.primary,
    this.cacheExtent,
    this.semanticChildCount,
    this.reverse,
    this.physics,
    this.scrollDirection,
    this.scrollController,
    Key? key,
  })  : builder = null,
        super(key: key);

  const AppRefresher.builder({
    Key? key,
    required this.controller,
    required this.builder,
    this.onRefresh,
    this.onLoading,
    this.onTwoLevel,
  })  : child = null,
        scrollController = null,
        scrollDirection = null,
        physics = null,
        reverse = null,
        semanticChildCount = null,
        dragStartBehavior = null,
        cacheExtent = null,
        primary = null,
        super(key: key);

  final Widget? child;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final OnTwoLevel? onTwoLevel;
  final RefreshController controller;
  final RefresherBuilder? builder;
  final Axis? scrollDirection;
  final bool? reverse;
  final ScrollController? scrollController;
  final bool? primary;
  final ScrollPhysics? physics;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior? dragStartBehavior;

  @override
  Widget build(BuildContext context) {
    return child != null
        ? SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: const WaterDropHeader(),
            footer: ClassicFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              canLoadingText: S.current.Tha_de_tai_them,
              failedText: S.current.Tai_that_bai,
              idleText: S.current.Keo_de_tai,
              loadingText: S.current.Dang_tai,
              noDataText: S.current.Khong_con_du_lieu,
            ),
            controller: controller,
            onRefresh: onRefresh,
            onLoading: onLoading,
            onTwoLevel: onTwoLevel,
            primary: primary,
            physics: physics,
            semanticChildCount: semanticChildCount,
            dragStartBehavior: dragStartBehavior,
            cacheExtent: cacheExtent,
            reverse: reverse,
            scrollDirection: scrollDirection,
            scrollController: scrollController,
            key: key,
            child: child,
          )
        : SmartRefresher.builder(
            controller: controller,
            builder: builder,
            onRefresh: onRefresh,
            onLoading: onLoading,
            onTwoLevel: onTwoLevel,
            enablePullDown: true,
            enablePullUp: true,
            key: key,
          );
  }
}
