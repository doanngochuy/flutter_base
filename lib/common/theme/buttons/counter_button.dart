import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/utils/utils.dart';

class CounterButton {
  CounterButton._();

  static String reformatCounterController(String text) {
    final f = NumberFormat("###,###.###", "tr_TR");
    return f.format(num.parse(text)).replaceAll(',', '-').replaceAll('.', ',').replaceAll('-', '.');
  }

  static Widget buildCounterButton({
    Key? key,
    Color borderColor = AppColor.grey300,
    double borderWidth = 2,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
    TextEditingController? controller,
    FocusNode? focusNode,
    int? maxLength,
    double? width,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    ValueChanged<String>? onChanged,
    bool hasBackground = true,
  }) =>
      Container(
        key: key,
        decoration: hasBackground
            ? BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(30.scaleSize),
                color: backgroundColor ?? AppColor.grey300WithOpacity500,
                border: Border.all(
                  color: borderColor,
                  width: borderWidth,
                ),
              )
            : null,
        padding: EdgeInsets.symmetric(horizontal: Insets.sm),
        width: width ?? 150.scaleSize,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: AppColor.blueLightWithOpacity100,
              child: IconButton(
                onPressed: () {
                  onMinus();
                  if (controller != null) {
                    controller.selection = TextSelection.fromPosition(
                      TextPosition(
                        offset: controller.text.length,
                      ),
                    );
                  }
                },
                alignment: Alignment.center,
                icon: const Icon(Icons.remove),
                color: AppColor.blueLight,
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.symmetric(horizontal: Insets.sm),
                ),
                textAlign: TextAlign.center,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.done,
                style: TextStyles.title1.copyWith(color: AppColor.blueLight),
                onChanged: onChanged,
                maxLength: maxLength,
                buildCounter: (
                  context, {
                  required currentLength,
                  required isFocused,
                  maxLength,
                }) =>
                    null,
                inputFormatters: [
                  AppTextInputFormatter.digitsWithComma,
                  AppTextInputFormatter.textWithCommaAndDot,
                ],
              ),
            ),
            CircleAvatar(
              backgroundColor: AppColor.blueLightWithOpacity100,
              child: IconButton(
                onPressed: () {
                  onPlus();
                  if (controller != null) {
                    controller.selection = TextSelection.fromPosition(
                      TextPosition(
                        offset: controller.text.length,
                      ),
                    );
                  }
                },
                alignment: Alignment.center,
                icon: const Icon(Icons.add),
                color: AppColor.blueLight,
              ),
            ),
          ],
        ),
      );
}
