import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/theme/theme.dart';

class ButtonSwitchMultiBuilder<T> extends StatefulWidget {
  const ButtonSwitchMultiBuilder({
    Key? key,
    this.initState,
    required this.items,
    required this.onChanged,
    required this.width,
    this.borderRadius,
    this.paddingItem,
    this.mainColor,
    this.textStyle,
  }) : assert(items.length >= 2, "items must have 2 elements at least" ),
        super(key: key);

  final T? initState;
  final List<ButtonSwitchItem<T>> items;
  final ValueChanged<T> onChanged;
  final double width;
  final double? borderRadius;
  final EdgeInsets? paddingItem;
  final Color? mainColor;
  final TextStyle? textStyle;

  @override
  State<ButtonSwitchMultiBuilder<T>> createState() => _ButtonSwitchMultiBuilderState<T>();
}

class _ButtonSwitchMultiBuilderState<T> extends State<ButtonSwitchMultiBuilder<T>> {
  T? switchState;

  @override
  void initState() {
    super.initState();
    switchState = widget.initState;
  }

  @override
  Widget build(BuildContext context) {
    const defaultRadius = Corners.custom20 - 1;
    final myRadius = widget.borderRadius ?? defaultRadius;
    final padding = widget.paddingItem ?? EdgeInsets.all(Insets.sm);
    final mainColor = widget.mainColor ?? AppColor.blueLight;
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: mainColor,
          width: Strokes.thin,
        ),
        borderRadius: BorderRadius.circular(
          widget.borderRadius != null ? widget.borderRadius! + 1 : defaultRadius + 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: CustomButton.fullColor(
              onPressed: () {
                setState(() => switchState = widget.items.first.value);
                widget.onChanged(widget.items.first.value);
              },
              text: widget.items.first.text,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(myRadius),
                  bottomLeft: Radius.circular(myRadius),
                ),
              ),
              background: switchState == widget.items.first.value ? mainColor : AppColor.white,
              textColor: switchState == widget.items.first.value ? AppColor.white : mainColor,
              padding: padding,
              textStyle: widget.textStyle,
            ),
          ),
          if (widget.items.length > 2)
            ...widget.items.getRange(1, widget.items.length - 1).map(
                  (e) => Expanded(
                    child: CustomButton.fullColor(
                      onPressed: () {
                        setState(() => switchState = e.value);
                        widget.onChanged(e.value);
                      },
                      text: e.text,
                      background: switchState == e.value ? mainColor : AppColor.white,
                      textColor: switchState == e.value ? AppColor.white : mainColor,
                      padding: padding,
                      textStyle: widget.textStyle,
                    ),
                  ),
                ),
          Expanded(
            child: CustomButton.fullColor(
              onPressed: () {
                setState(() => switchState = widget.items.last.value);
                widget.onChanged(widget.items.last.value);
              },
              text: widget.items.last.text,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(myRadius),
                  bottomRight: Radius.circular(myRadius),
                ),
              ),
              background: switchState == widget.items.last.value ? mainColor : AppColor.white,
              textColor: switchState == widget.items.last.value ? AppColor.white : mainColor,
              padding: padding,
              textStyle: widget.textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
