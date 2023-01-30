part of 'expandable.dart';

/// Makes an [ExpandableController] available to the widget subtree.
/// Useful for making multiple [Expandable] widgets synchronized with a single controller.
class ExpandableNotifier extends StatefulWidget {
  final ExpandableController? controller;
  final bool? initialExpanded;
  final Widget child;

  const ExpandableNotifier(
      {
      // An optional key
      Key? key,

      /// If the controller is not provided, it's created with the initial value of `initialExpanded`.
      this.controller,

      /// Initial expanded state. Must not be used together with [controller].
      this.initialExpanded,

      /// The child can be any widget which contains [Expandable] widgets in its widget tree.
      required this.child})
      : assert(!(controller != null && initialExpanded != null)),
        super(key: key);

  @override
  ExpandableNotifierState createState() => ExpandableNotifierState();
}

class ExpandableNotifierState extends State<ExpandableNotifier> {
  ExpandableController? controller;
  ExpandableThemeData? theme;

  @override
  void initState() {
    super.initState();
    controller =
        widget.controller ?? ExpandableController(initialExpanded: widget.initialExpanded ?? false);
  }

  @override
  void didUpdateWidget(ExpandableNotifier oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller && widget.controller != null) {
      setState(() {
        controller = widget.controller;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cn = _ExpandableControllerNotifier(controller: controller, child: widget.child);
    return theme != null ? _ExpandableThemeNotifier(themeData: theme, child: cn) : cn;
  }
}

/// Makes an [ExpandableController] available to the widget subtree.
/// Useful for making multiple [Expandable] widgets synchronized with a single controller.
class _ExpandableControllerNotifier extends InheritedNotifier<ExpandableController> {
  const _ExpandableControllerNotifier({
    required ExpandableController? controller,
    required Widget child,
  }) : super(notifier: controller, child: child);
}

/// Makes an [ExpandableController] available to the widget subtree.
/// Useful for making multiple [Expandable] widgets synchronized with a single controller.
class _ExpandableThemeNotifier extends InheritedWidget {
  final ExpandableThemeData? themeData;

  const _ExpandableThemeNotifier({required this.themeData, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return !(oldWidget is _ExpandableThemeNotifier && oldWidget.themeData == themeData);
  }
}

/// Controls the state (expanded or collapsed) of one or more [Expandable].
/// The controller should be provided to [Expandable] via [ExpandableNotifier].
class ExpandableController extends ValueNotifier<bool> {
  /// Returns [true] if the state is expanded, [false] if collapsed.
  bool get expanded => value;

  ExpandableController({
    bool? initialExpanded,
  }) : super(initialExpanded ?? false);

  /// Sets the expanded state.
  set expanded(bool exp) {
    value = exp;
  }

  /// Sets the expanded state to the opposite of the current state.
  void toggle() {
    expanded = !expanded;
  }

  static ExpandableController? of(BuildContext context,
      {bool rebuildOnChange = true, bool required = false}) {
    final notifier = rebuildOnChange
        ? context.dependOnInheritedWidgetOfExactType<_ExpandableControllerNotifier>()
        : context.findAncestorWidgetOfExactType<_ExpandableControllerNotifier>();
    assert(notifier != null || !required, "ExpandableNotifier is not found in widget tree");
    return notifier?.notifier;
  }
}
