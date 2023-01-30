// A library of Flutter widgets that allow creating expandable panels
library expandable;

import 'dart:math' as math;

import 'package:flutter/material.dart';

part 'theme.dart';
part 'notifier.dart';
part 'fragments.dart';

typedef ExpandableBuilder = Widget Function(BuildContext context, Widget collapsed, Widget expanded);

/// Determines the placement of the expand/collapse icon in [ExpandablePanel]
enum ExpandablePanelIconPlacement {
  /// The icon is on the left of the header
  left,

  /// The icon is on the right of the header
  right,
}

/// Determines the alignment of the header relative to the expand icon
enum ExpandablePanelHeaderAlignment {
  /// The header and the icon are aligned at their top positions
  top,

  /// The header and the icon are aligned at their center positions
  center,

  /// The header and the icon are aligned at their bottom positions
  bottom,
}

/// Determines vertical alignment of the body
enum ExpandablePanelBodyAlignment {
  /// The body is positioned at the left
  left,

  /// The body is positioned in the center
  center,

  /// The body is positioned at the right
  right,
}

/// Shows either the expanded or the collapsed child depending on the state.
/// The state is determined by an instance of [ExpandableController] provided by [ScopedModel]
class Expandable extends StatelessWidget {
  /// Whe widget to show when collapsed
  final Widget collapsed;

  /// The widget to show when expanded
  final Widget expanded;

  /// If the controller is not specified, it will be retrieved from the context
  final ExpandableController? controller;

  final ExpandableThemeData? theme;

  const Expandable({
    Key? key,
    required this.collapsed,
    required this.expanded,
    this.controller,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = this.controller ?? ExpandableController.of(context, required: true);
    final theme = ExpandableThemeData.withDefaults(this.theme, context);

    return AnimatedCrossFade(
      alignment: theme.alignment!,
      firstChild: collapsed,
      secondChild: expanded,
      firstCurve:
          Interval(theme.collapsedFadeStart, theme.collapsedFadeEnd, curve: theme.fadeCurve!),
      secondCurve:
          Interval(theme.expandedFadeStart, theme.expandedFadeEnd, curve: theme.fadeCurve!),
      sizeCurve: theme.sizeCurve!,
      crossFadeState:
          controller?.expanded ?? true ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: theme.animationDuration!,
    );
  }
}





