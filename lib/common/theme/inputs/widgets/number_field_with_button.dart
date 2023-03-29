import 'package:flutter/material.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';

class NumberFieldWithButton extends StatefulWidget {
  const NumberFieldWithButton(
      {Key? key, this.initialValue, this.onChanged, this.textBackgroundColor})
      : super(key: key);

  final double? initialValue;
  final Color? textBackgroundColor;
  final ValueChanged<double?>? onChanged;

  @override
  State<NumberFieldWithButton> createState() => _NumberFieldWithButtonState();
}

class _NumberFieldWithButtonState extends State<NumberFieldWithButton> {
  late double value;
  final FocusNode focusNode = FocusNode();
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    value = widget.initialValue ?? 0;
    textController.text = truncateNumberToString(value);
  }

  void decreaseValue() {
    focusNode.unfocus();
    if (value > 0) {
      setState(() {
        value -= 1;
        textController.text = truncateNumberToString(value);
      });
    }
  }

  void increaseValue() {
    focusNode.unfocus();
    setState(() {
      value += 1;
      textController.text = truncateNumberToString(value);
    });
  }

  void onChangedValue(text) {
    value =
        (AppTextInputFormatter.reversedFromCommaAndDotToNumber(text) ?? 0).toDouble();
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: widget.textBackgroundColor ?? AppColor.grey300WithOpacity500,
      ),
      padding: EdgeInsets.symmetric(horizontal: Insets.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 25.scaleSize,
            margin: EdgeInsets.only(right: Insets.xs),
            child: InkWell(
              borderRadius: BorderRadius.circular(Corners.xl),
              hoverColor: AppColor.blueLightWithOpacity100,
              onTap: decreaseValue,
              child: Icon(
                Icons.remove,
                color: AppColor.blueLight,
                size: 20.scaleSize,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: CustomInput.numericOutline(
                controller: textController,
                focusNode: focusNode,
                onChanged: onChangedValue,
            ),
          ),
          Container(
            width: 25.scaleSize,
            margin: EdgeInsets.only(left: Insets.xs),
            child: InkWell(
              borderRadius: BorderRadius.circular(Corners.xl),
              hoverColor: AppColor.blueLightWithOpacity100,
              onTap: increaseValue,
              child: Icon(
                Icons.add,
                color: AppColor.blueLight,
                size: 20.scaleSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
