part of 'button_switch.dart';

class ButtonSwitchItem<T> {
  final String text;
  final T value;

  const ButtonSwitchItem({
    required this.text,
    required this.value,
  });
}

class ButtonSwitchBuilder<T> extends StatefulWidget {
  const ButtonSwitchBuilder({
    Key? key,
    this.initState,
    required this.item1,
    required this.item2,
    required this.onChanged,
    this.width,
    this.height,
    this.borderRadius,
    this.paddingItem,
    this.mainColor,
    this.textStyle,
    this.fontSize,
  }) : super(key: key);

  final T? initState;
  final ButtonSwitchItem<T> item1;
  final ButtonSwitchItem<T> item2;
  final ValueChanged<T> onChanged;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? borderRadius;
  final EdgeInsets? paddingItem;
  final Color? mainColor;
  final TextStyle? textStyle;

  @override
  State<ButtonSwitchBuilder<T>> createState() => _ButtonSwitchBuilderState<T>();
}

class _ButtonSwitchBuilderState<T> extends State<ButtonSwitchBuilder<T>> {
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
    return IntrinsicWidth(
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          border: Border.all(
            color: mainColor,
            width: Strokes.thin,
          ),
          borderRadius: BorderRadius.circular(
            widget.borderRadius != null
                ? widget.borderRadius! + 1
                : defaultRadius + 1,
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: CustomButton.fullColor(
                onPressed: () {
                  setState(() => switchState = widget.item1.value);
                  widget.onChanged(widget.item1.value);
                },
                text: widget.item1.text,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(myRadius),
                    bottomLeft: Radius.circular(myRadius),
                  ),
                ),
                background: switchState == widget.item1.value
                    ? mainColor
                    : AppColor.white,
                textColor: switchState == widget.item1.value
                    ? AppColor.white
                    : mainColor,
                fontSize: widget.fontSize,
                padding: padding,
                textStyle: widget.textStyle,
              ),
            ),
            Expanded(
              child: CustomButton.fullColor(
                onPressed: () {
                  setState(() => switchState = widget.item2.value);
                  widget.onChanged(widget.item2.value);
                },
                text: widget.item2.text,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(myRadius),
                    bottomRight: Radius.circular(myRadius),
                  ),
                ),
                background: switchState == widget.item2.value
                    ? mainColor
                    : AppColor.white,
                textColor: switchState == widget.item2.value
                    ? AppColor.white
                    : mainColor,
                padding: padding,
                textStyle: widget.textStyle,
                fontSize: widget.fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
