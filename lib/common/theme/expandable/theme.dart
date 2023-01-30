part of 'expandable.dart';

class ExpandableThemeData {
  static ExpandableThemeData defaults = const ExpandableThemeData(
    iconColor: Colors.black54,
    useInkWell: true,
    inkWellBorderRadius: BorderRadius.zero,
    animationDuration: Duration(milliseconds: 300),
    scrollAnimationDuration: Duration(milliseconds: 300),
    crossFadePoint: 0.5,
    fadeCurve: Curves.linear,
    sizeCurve: Curves.fastOutSlowIn,
    alignment: Alignment.topLeft,
    headerAlignment: ExpandablePanelHeaderAlignment.top,
    bodyAlignment: ExpandablePanelBodyAlignment.left,
    iconPlacement: ExpandablePanelIconPlacement.right,
    tapHeaderToExpand: true,
    tapBodyToExpand: false,
    tapBodyToCollapse: false,
    hasIcon: true,
    iconSize: 24.0,
    iconPadding: EdgeInsets.all(8.0),
    iconRotationAngle: -math.pi,
    expandIcon: Icons.expand_more,
    collapseIcon: Icons.expand_more,
  );

  static const ExpandableThemeData empty = ExpandableThemeData();

  // Expand icon color.
  final Color? iconColor;

  // If true then [InkWell] will be used in the header for a ripple effect.
  final bool? useInkWell;

  // The duration of the transition between collapsed and expanded states.
  final Duration? animationDuration;

  // The duration of the scroll animation to make the expanded widget visible.
  final Duration? scrollAnimationDuration;

  /// The point in the cross-fade animation timeline (from 0 to 1)
  /// where the [collapsed] and [expanded] widgets are half-visible.
  ///
  /// If set to 0, the [expanded] widget will be shown immediately in full opacity
  /// when the size transition starts. This is useful if the collapsed widget is
  /// empty or if dealing with text that is shown partially in the collapsed state.
  /// This is the default value.
  ///
  /// If set to 0.5, the [expanded] and the [collapsed] widget will be shown
  /// at half of their opacity in the middle of the size animation with a
  /// cross-fade effect throughout the entire size transition.
  ///
  /// If set to 1, the [expanded] widget will be shown at the very end of the size animation.
  ///
  /// When collapsing, the effect of this setting is reversed. For example, if the value is 0
  /// then the [expanded] widget will remain to be shown until the end of the size animation.
  final double? crossFadePoint;

  /// The alignment of widgets during animation between expanded and collapsed states.
  final AlignmentGeometry? alignment;

  // Fade animation curve between expanded and collapsed states.
  final Curve? fadeCurve;

  // Size animation curve between expanded and collapsed states.
  final Curve? sizeCurve;

  // The alignment of the header for `ExpandablePanel`.
  final ExpandablePanelHeaderAlignment? headerAlignment;

  // The alignment of the body for `ExpandablePanel`.
  final ExpandablePanelBodyAlignment? bodyAlignment;

  /// Expand icon placement.
  final ExpandablePanelIconPlacement? iconPlacement;

  /// If true, the header of [ExpandablePanel] can be clicked by the user to expand or collapse.
  final bool? tapHeaderToExpand;

  /// If true, the body of [ExpandablePanel] can be clicked by the user to expand.
  final bool? tapBodyToExpand;

  /// If true, the body of [ExpandablePanel] can be clicked by the user to collapse.
  final bool? tapBodyToCollapse;

  /// If true, an icon is shown in the header of [ExpandablePanel].
  final bool? hasIcon;

  /// Expand icon size.
  final double? iconSize;

  /// Expand icon padding.
  final EdgeInsets? iconPadding;

  /// Icon rotation angle in clockwise radians. For example, specify `math.pi` to rotate the icon by 180 degrees
  /// clockwise when clicking on the expand button.
  final double? iconRotationAngle;

  /// The icon in the collapsed state.
  final IconData? expandIcon;

  /// The icon in the expanded state. If you specify the same icon as `expandIcon`, the `expandIcon` icon will
  /// be shown upside-down in the expanded state.
  final IconData? collapseIcon;

  ///The [BorderRadius] for the [InkWell], if `inkWell` is set to true
  final BorderRadius? inkWellBorderRadius;

  const ExpandableThemeData({
    this.iconColor,
    this.useInkWell,
    this.animationDuration,
    this.scrollAnimationDuration,
    this.crossFadePoint,
    this.fadeCurve,
    this.sizeCurve,
    this.alignment,
    this.headerAlignment,
    this.bodyAlignment,
    this.iconPlacement,
    this.tapHeaderToExpand,
    this.tapBodyToExpand,
    this.tapBodyToCollapse,
    this.hasIcon,
    this.iconSize,
    this.iconPadding,
    this.iconRotationAngle,
    this.expandIcon,
    this.collapseIcon,
    this.inkWellBorderRadius,
  });

  static ExpandableThemeData combine(ExpandableThemeData? theme, ExpandableThemeData? defaults) {
    if (defaults == null || defaults.isEmpty()) {
      return theme ?? empty;
    } else if (theme == null || theme.isEmpty()) {
      return defaults;
    } else if (theme.isFull()) {
      return theme;
    } else {
      return ExpandableThemeData(
        iconColor: theme.iconColor ?? defaults.iconColor,
        useInkWell: theme.useInkWell ?? defaults.useInkWell,
        inkWellBorderRadius: theme.inkWellBorderRadius ?? defaults.inkWellBorderRadius,
        animationDuration: theme.animationDuration ?? defaults.animationDuration,
        scrollAnimationDuration: theme.scrollAnimationDuration ?? defaults.scrollAnimationDuration,
        crossFadePoint: theme.crossFadePoint ?? defaults.crossFadePoint,
        fadeCurve: theme.fadeCurve ?? defaults.fadeCurve,
        sizeCurve: theme.sizeCurve ?? defaults.sizeCurve,
        alignment: theme.alignment ?? defaults.alignment,
        headerAlignment: theme.headerAlignment ?? defaults.headerAlignment,
        bodyAlignment: theme.bodyAlignment ?? defaults.bodyAlignment,
        iconPlacement: theme.iconPlacement ?? defaults.iconPlacement,
        tapHeaderToExpand: theme.tapHeaderToExpand ?? defaults.tapHeaderToExpand,
        tapBodyToExpand: theme.tapBodyToExpand ?? defaults.tapBodyToExpand,
        tapBodyToCollapse: theme.tapBodyToCollapse ?? defaults.tapBodyToCollapse,
        hasIcon: theme.hasIcon ?? defaults.hasIcon,
        iconSize: theme.iconSize ?? defaults.iconSize,
        iconPadding: theme.iconPadding ?? defaults.iconPadding,
        iconRotationAngle: theme.iconRotationAngle ?? defaults.iconRotationAngle,
        expandIcon: theme.expandIcon ?? defaults.expandIcon,
        collapseIcon: theme.collapseIcon ?? defaults.collapseIcon,
      );
    }
  }

  double get collapsedFadeStart => crossFadePoint! < 0.5 ? 0 : (crossFadePoint! * 2 - 1);

  double get collapsedFadeEnd => crossFadePoint! < 0.5 ? 2 * crossFadePoint! : 1;

  double get expandedFadeStart => crossFadePoint! < 0.5 ? 0 : (crossFadePoint! * 2 - 1);

  double get expandedFadeEnd => crossFadePoint! < 0.5 ? 2 * crossFadePoint! : 1;

  ExpandableThemeData? nullIfEmpty() {
    return isEmpty() ? null : this;
  }

  bool isEmpty() {
    return this == empty;
  }

  bool isFull() {
    return iconColor != null &&
        useInkWell != null &&
        inkWellBorderRadius != null &&
        animationDuration != null &&
        scrollAnimationDuration != null &&
        crossFadePoint != null &&
        fadeCurve != null &&
        sizeCurve != null &&
        alignment != null &&
        headerAlignment != null &&
        bodyAlignment != null &&
        iconPlacement != null &&
        tapHeaderToExpand != null &&
        tapBodyToExpand != null &&
        tapBodyToCollapse != null &&
        hasIcon != null &&
        iconRotationAngle != null &&
        expandIcon != null &&
        collapseIcon != null;
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    } else if (other is ExpandableThemeData) {
      return iconColor == other.iconColor &&
          useInkWell == other.useInkWell &&
          inkWellBorderRadius == other.inkWellBorderRadius &&
          animationDuration == other.animationDuration &&
          scrollAnimationDuration == other.scrollAnimationDuration &&
          crossFadePoint == other.crossFadePoint &&
          fadeCurve == other.fadeCurve &&
          sizeCurve == other.sizeCurve &&
          alignment == other.alignment &&
          headerAlignment == other.headerAlignment &&
          bodyAlignment == other.bodyAlignment &&
          iconPlacement == other.iconPlacement &&
          tapHeaderToExpand == other.tapHeaderToExpand &&
          tapBodyToExpand == other.tapBodyToExpand &&
          tapBodyToCollapse == other.tapBodyToCollapse &&
          hasIcon == other.hasIcon &&
          iconRotationAngle == other.iconRotationAngle &&
          expandIcon == other.expandIcon &&
          collapseIcon == other.collapseIcon;
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    return 0; // we don't care
  }

  static ExpandableThemeData of(BuildContext context, {bool rebuildOnChange = true}) {
    final notifier = rebuildOnChange
        ? context.dependOnInheritedWidgetOfExactType<_ExpandableThemeNotifier>()
        : context.findAncestorWidgetOfExactType<_ExpandableThemeNotifier>();
    return notifier?.themeData ?? defaults;
  }

  static ExpandableThemeData withDefaults(ExpandableThemeData? theme, BuildContext context,
      {bool rebuildOnChange = true}) {
    if (theme != null && theme.isFull()) {
      return theme;
    } else {
      return combine(combine(theme, of(context, rebuildOnChange: rebuildOnChange)), defaults);
    }
  }
}

class ExpandableTheme extends StatelessWidget {
  final ExpandableThemeData data;
  final Widget child;

  const ExpandableTheme({Key? key, required this.data, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _ExpandableThemeNotifier? n =
        context.dependOnInheritedWidgetOfExactType<_ExpandableThemeNotifier>();
    return _ExpandableThemeNotifier(
      themeData: ExpandableThemeData.combine(data, n?.themeData),
      child: child,
    );
  }
}
