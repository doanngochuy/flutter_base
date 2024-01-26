import 'package:flutter/material.dart';
import 'package:EMO/common/styles/styles.dart';

@Deprecated(
  "It will delete in the future",
)
class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox(
      {Key? key,
      required this.isChecked,
      this.hasCheck = false,
      this.size = 24,
      this.checkColor = AppColor.white,
      this.checkedBackgroundColor = AppColor.orange,
      this.backgroundColor = Colors.transparent,
      this.borderColor = AppColor.orange,
      this.borderRadius = 5.0,
      required this.onChanged})
      : super(key: key);

  final bool? isChecked;
  final bool hasCheck;
  final double size;
  final Color checkColor;
  final Color checkedBackgroundColor;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final ValueChanged<bool?>? onChanged;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    bool value = widget.isChecked!;
    double checkSize = widget.size * 0.9;
    double smallContainerSize = widget.size * 0.7;
    return InkWell(
      onTap: () {
        setState(() {
          value = !value;
          widget.onChanged!(value);
        });
      },
      child: Container(
        height: widget.size,
        width: widget.size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: value ? widget.checkedBackgroundColor : widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(color: widget.borderColor, width: 0.5),
        ),
        child: widget.isChecked!
            ? Icon(
                Icons.check,
                size: checkSize,
                color: widget.checkColor,
              )
            : widget.hasCheck
                ? Container(
                    height: smallContainerSize,
                    width: smallContainerSize,
                    decoration: BoxDecoration(
                      color: widget.checkedBackgroundColor,
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                  )
                : const SizedBox(),
      ),
    );
  }
}

@Deprecated(
  "It will delete in the future",
)
class CustomCheckBoxWithTitle extends StatefulWidget {
  const CustomCheckBoxWithTitle({
    Key? key,
    required this.initValue,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  final bool initValue;
  final String label;
  final Function(bool?) onChanged;

  @override
  State<CustomCheckBoxWithTitle> createState() => _CustomCheckBoxWithTitleState();
}

class _CustomCheckBoxWithTitleState extends State<CustomCheckBoxWithTitle> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
        widget.onChanged(isChecked);
      },
      child: Padding(
        padding: EdgeInsets.all(Insets.med),
        child: Row(
          children: <Widget>[
            Checkbox(
              value: isChecked,
              checkColor: AppColor.white,
              shape: const RoundedRectangleBorder(
                borderRadius: Corners.smBorder,
              ),
              onChanged: (bool? newValue) {
                setState(() {
                  isChecked = newValue ?? true;
                });
                widget.onChanged(isChecked);
              },
            ),
            Expanded(
              child: Text(
                widget.label,
                maxLines: 4,
                style: TextStyles.title1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
