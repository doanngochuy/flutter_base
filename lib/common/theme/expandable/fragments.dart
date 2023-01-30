part of 'expandable.dart';

/// A configurable widget for showing user-expandable content with an optional expand button.
class ExpandablePanel extends StatelessWidget {
  /// If specified, the header is always shown, and the expandable part is shown under the header
  final Widget? header;

  /// The widget shown in the collapsed state
  final Widget collapsed;

  /// The widget shown in the expanded state
  final Widget expanded;

  /// Builds an Expandable object, optional
  final ExpandableBuilder? builder;

  /// Callback when [ExpandablePanel] state changes,
  /// return **true** value on [ExpandablePanel] expanded
  final ValueChanged<bool>? onTap;

  /// An optional controller. If not specified, a default controller will be
  /// obtained from a surrounding [ExpandableNotifier]. If that does not exist,
  /// the controller will be created with the initial state of [initialExpanded].
  final ExpandableController? controller;

  final ExpandableThemeData? theme;

  const ExpandablePanel({
    Key? key,
    this.header,
    required this.collapsed,
    required this.expanded,
    this.controller,
    this.builder,
    this.theme,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ExpandableThemeData.withDefaults(this.theme, context);

    Widget buildHeaderRow() {
      CrossAxisAlignment calculateHeaderCrossAxisAlignment() {
        switch (theme.headerAlignment!) {
          case ExpandablePanelHeaderAlignment.top:
            return CrossAxisAlignment.start;
          case ExpandablePanelHeaderAlignment.center:
            return CrossAxisAlignment.center;
          case ExpandablePanelHeaderAlignment.bottom:
            return CrossAxisAlignment.end;
        }
      }

      Widget wrapWithExpandableButton({required Widget? widget, required bool wrap}) {
        return wrap
            ? ExpandableButton(theme: theme, onTap: onTap, child: widget)
            : widget ?? Container();
      }

      if (!theme.hasIcon!) {
        return wrapWithExpandableButton(widget: header, wrap: theme.tapHeaderToExpand!);
      } else {
        final rowChildren = <Widget>[
          Expanded(
            child: header ?? Container(),
          ),
          // ignore: deprecated_member_use_from_same_package
          wrapWithExpandableButton(
              widget: ExpandableIcon(theme: theme), wrap: !theme.tapHeaderToExpand!)
        ];
        return wrapWithExpandableButton(
            widget: Row(
              crossAxisAlignment: calculateHeaderCrossAxisAlignment(),
              children: theme.iconPlacement! == ExpandablePanelIconPlacement.right
                  ? rowChildren
                  : rowChildren.reversed.toList(),
            ),
            wrap: theme.tapHeaderToExpand!);
      }
    }

    Widget buildBody() {
      Widget wrapBody(Widget child, bool tap) {
        Alignment calcAlignment() {
          switch (theme.bodyAlignment!) {
            case ExpandablePanelBodyAlignment.left:
              return Alignment.topLeft;
            case ExpandablePanelBodyAlignment.center:
              return Alignment.topCenter;
            case ExpandablePanelBodyAlignment.right:
              return Alignment.topRight;
          }
        }

        final widget = Align(
          alignment: calcAlignment(),
          child: child,
        );

        if (!tap) {
          return widget;
        }
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: widget,
          onTap: () {
            final controller = ExpandableController.of(context);
            controller?.toggle();

            onTap?.call(controller?.expanded ?? false);
          },
        );
      }

      final builder = this.builder ??
          (context, collapsed, expanded) {
            return Expandable(
              collapsed: collapsed,
              expanded: expanded,
              theme: theme,
            );
          };

      return builder(context, wrapBody(collapsed, theme.tapBodyToExpand!),
          wrapBody(expanded, theme.tapBodyToCollapse!));
    }

    Widget buildWithHeader() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeaderRow(),
          buildBody(),
        ],
      );
    }

    final panel = header != null ? buildWithHeader() : buildBody();

    if (controller != null) {
      return ExpandableNotifier(
        controller: controller,
        child: panel,
      );
    } else {
      final controller = ExpandableController.of(context, rebuildOnChange: false);
      if (controller == null) {
        return ExpandableNotifier(
          child: panel,
        );
      } else {
        return panel;
      }
    }
  }
}

/// An down/up arrow icon that toggles the state of [ExpandableController] when the user clicks on it.
/// The model is accessed via [ScopedModelDescendant].
class ExpandableIcon extends StatefulWidget {
  final ExpandableThemeData? theme;

  const ExpandableIcon({
    Key? key,
    this.theme,
    // ignore: deprecated_member_use_from_same_package
  }) : super(key: key);

  @override
  ExpandableIconState createState() => ExpandableIconState();
}

class ExpandableIconState extends State<ExpandableIcon> with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  ExpandableThemeData? theme;
  ExpandableController? controller;

  @override
  void initState() {
    super.initState();
    final theme = ExpandableThemeData.withDefaults(widget.theme, context, rebuildOnChange: false);
    animationController = AnimationController(duration: theme.animationDuration, vsync: this);
    animation = animationController!
        .drive(Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: theme.sizeCurve!)));
    controller = ExpandableController.of(context, rebuildOnChange: false, required: true);
    controller?.addListener(_expandedStateChanged);
    if (controller?.expanded ?? true) {
      animationController!.value = 1.0;
    }
  }

  @override
  void dispose() {
    controller?.removeListener(_expandedStateChanged);
    animationController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ExpandableIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      theme = null;
    }
  }

  _expandedStateChanged() {
    if (controller!.expanded &&
        const [AnimationStatus.dismissed, AnimationStatus.reverse]
            .contains(animationController!.status)) {
      animationController!.forward();
    } else if (!controller!.expanded &&
        const [AnimationStatus.completed, AnimationStatus.forward]
            .contains(animationController!.status)) {
      animationController!.reverse();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller2 = ExpandableController.of(context, rebuildOnChange: false, required: true);
    if (controller2 != controller) {
      controller?.removeListener(_expandedStateChanged);
      controller = controller2;
      controller?.addListener(_expandedStateChanged);
      if (controller?.expanded ?? true) {
        animationController!.value = 1.0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ExpandableThemeData.withDefaults(widget.theme, context);

    return Padding(
      padding: theme.iconPadding!,
      child: AnimatedBuilder(
        animation: animation!,
        builder: (context, child) {
          final showSecondIcon =
              theme.collapseIcon! != theme.expandIcon! && animationController!.value >= 0.5;
          return Transform.rotate(
            angle: theme.iconRotationAngle! *
                (showSecondIcon ? -(1.0 - animationController!.value) : animationController!.value),
            child: Icon(
              showSecondIcon ? theme.collapseIcon! : theme.expandIcon!,
              color: theme.iconColor!,
              size: theme.iconSize!,
            ),
          );
        },
      ),
    );
  }
}

/// Toggles the state of [ExpandableController] when the user clicks on it.
class ExpandableButton extends StatelessWidget {
  final Widget? child;
  final ExpandableThemeData? theme;
  final ValueChanged<bool>? onTap;

  const ExpandableButton({Key? key, this.child, this.theme, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ExpandableController.of(context, required: true);
    final theme = ExpandableThemeData.withDefaults(this.theme, context);

    if (theme.useInkWell!) {
      return InkWell(
        onTap: () {
          controller?.toggle();

          onTap?.call(controller?.expanded ?? false);
        },
        borderRadius: theme.inkWellBorderRadius!,
        child: child,
      );
    } else {
      return GestureDetector(
        onTap: () {
          controller?.toggle();

          onTap?.call(controller?.expanded ?? false);
        },
        child: child,
      );
    }
  }
}

/// Ensures that the child is visible on the screen by scrolling the outer viewport
/// when the outer [ExpandableNotifier] delivers a change event.
///
/// See also:
///
/// * [RenderObject.showOnScreen]
class ScrollOnExpand extends StatefulWidget {
  final Widget child;

  /// If true then the widget will be scrolled to become visible when expanded
  final bool scrollOnExpand;

  /// If true then the widget will be scrolled to become visible when collapsed
  final bool scrollOnCollapse;

  final ExpandableThemeData? theme;

  const ScrollOnExpand({
    Key? key,
    required this.child,
    this.scrollOnExpand = true,
    this.scrollOnCollapse = true,
    this.theme,
  }) : super(key: key);

  @override
  ScrollOnExpandState createState() => ScrollOnExpandState();
}

class ScrollOnExpandState extends State<ScrollOnExpand> {
  ExpandableController? _controller;
  int _isAnimating = 0;
  BuildContext? _lastContext;
  ExpandableThemeData? _theme;

  @override
  void initState() {
    super.initState();
    _controller = ExpandableController.of(context, rebuildOnChange: false, required: true);
    _controller?.addListener(_expandedStateChanged);
  }

  @override
  void didUpdateWidget(ScrollOnExpand oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newController = ExpandableController.of(context, rebuildOnChange: false, required: true);
    if (newController != _controller) {
      _controller?.removeListener(_expandedStateChanged);
      _controller = newController;
      _controller?.addListener(_expandedStateChanged);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.removeListener(_expandedStateChanged);
  }

  _animationComplete() {
    _isAnimating--;
    if (_isAnimating == 0 && _lastContext != null && mounted) {
      if ((_controller?.expanded ?? true && widget.scrollOnExpand) ||
          (!(_controller?.expanded ?? true) && widget.scrollOnCollapse)) {
        _lastContext?.findRenderObject()?.showOnScreen(duration: _animationDuration);
      }
    }
  }

  Duration get _animationDuration {
    return _theme?.scrollAnimationDuration ?? ExpandableThemeData.defaults.animationDuration!;
  }

  _expandedStateChanged() {
    if (_theme != null) {
      _isAnimating++;
      Future.delayed(_animationDuration + const Duration(milliseconds: 10), _animationComplete);
    }
  }

  @override
  Widget build(BuildContext context) {
    _lastContext = context;
    _theme = ExpandableThemeData.withDefaults(widget.theme, context);
    return widget.child;
  }
}
