import 'package:flutter/material.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/utils/utils.dart';

class CustomButton {
  const CustomButton._();

  static Widget outline({
    Key? key,
    required VoidCallback onPressed,
    required String text,
    Color textColor = AppColor.black800,
    Color borderColor = AppColor.grey300,
    double radius = Corners.med,
    Color background = AppColor.white,
    Color shadowColor = Colors.transparent,
    EdgeInsets? padding,
    Color? clickColor,
    double? height,
    double? width,
    Icon? icon,
    bool isRightIcon = false,
    TextStyle? textStyle,
    double borderWidth = Strokes.thin,
    List<BoxShadow>? boxShadow,
    TextAlign textAlign = TextAlign.center,
    OutlinedBorder? shape,
    int maxLines = 4,
  }) =>
      Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow: boxShadow,
        ),
        child: ElevatedButton(
          key: key,
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: clickColor,
            backgroundColor: background,
            shape: shape ??
                RoundedRectangleBorder(
                  side: BorderSide(color: borderColor, width: borderWidth),
                  borderRadius: BorderRadius.circular(radius),
                ),
            padding: EdgeInsets.zero,
            shadowColor: shadowColor,
            elevation: 0,
            minimumSize: Size.zero,
          ),
          child: Padding(
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: Insets.lg,
                  vertical: Insets.med,
                ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null && !isRightIcon)
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: icon,
                  ),
                Flexible(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    maxLines: maxLines,
                    style: textStyle ??
                        TextStyles.button1.copyWith(
                          color: textColor,
                          height: 0,
                        ),
                  ),
                ),
                if (icon != null && isRightIcon)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: icon,
                  ),
              ],
            ),
          ),
        ),
      );

  static Widget outlineWithIcon({
    Key? key,
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
    Color textColor = AppColor.black800,
    Color borderColor = AppColor.grey300,
    Color background = AppColor.white,
    Color shadowColor = Colors.transparent,
    isRightIcon = false,
    Color? clickColor,
    Color? iconColor,
    double? radius,
    EdgeInsets? padding,
    double? height,
    double? width,
    TextStyle? textStyle,
  }) =>
      SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          key: key,
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: clickColor,
            backgroundColor: background,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(radius ?? Corners.med),
            ),
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: Insets.lg,
                  vertical: Insets.med,
                ),
            shadowColor: shadowColor,
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (!isRightIcon)
                Icon(
                  icon,
                  color: iconColor ?? AppColor.black800,
                ),
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle ??
                      TextStyles.body1.copyWith(
                        color: textColor,
                        height: 0,
                      ),
                ),
              ),
              if (isRightIcon)
                Icon(
                  icon,
                  color: iconColor ?? AppColor.black800,
                ),
            ],
          ),
        ),
      );

  static Widget customOutline({
    required VoidCallback onPressed,
    required Widget child,
    Color borderColor = AppColor.grey300,
    double? radius,
    Color background = AppColor.white,
    Color shadowColor = Colors.transparent,
    EdgeInsets? padding,
    Color? clickColor,
    double? height,
    double? width,
  }) =>
      SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: clickColor,
            backgroundColor: background,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor, width: Strokes.thin),
              borderRadius: BorderRadius.circular(radius ?? Corners.med),
            ),
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: Insets.lg,
                  vertical: Insets.med,
                ),
            shadowColor: shadowColor,
            elevation: 0,
          ),
          child: child,
        ),
      );

  static Widget fullColor({
    Key? key,
    required VoidCallback onPressed,
    required String text,
    bool deactivate = false,
    double radius = Corners.med,
    Color background = AppColor.blueLight,
    Color shadowColor = Colors.transparent,
    EdgeInsets? padding,
    Color? clickColor,
    double? height,
    double? width,
    Icon? icon,
    bool isRightIcon = false,
    TextStyle? textStyle,
    Color textColor = AppColor.white,
    double elevation = 0,
    List<BoxShadow>? boxShadow,
    OutlinedBorder? shape,
    double? fontSize,
    int? maxLines,
  }) =>
      Container(
        key: key,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow: boxShadow,
        ),
        child: AbsorbPointer(
          absorbing: deactivate,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: clickColor,
              backgroundColor: deactivate ? background.withOpacity(0.6) : background,
              shape: shape ??
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius),
                  ),
              padding: EdgeInsets.zero,
              shadowColor: shadowColor,
              elevation: elevation,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Padding(
              padding: padding ?? EdgeInsets.symmetric(horizontal: Insets.lg, vertical: Insets.med),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null && !isRightIcon)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: icon,
                    ),
                  Flexible(
                    child: Text(
                      text,
                      style: textStyle ??
                          TextStyles.button1.copyWith(
                            color: textColor,
                            height: 0,
                            fontSize: fontSize,
                          ),
                      textAlign: TextAlign.center,
                      maxLines: maxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (icon != null && isRightIcon)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: icon,
                    ),
                ],
              ),
            ),
          ),
        ),
      );

  static Widget customFullColor({
    Key? key,
    required VoidCallback onPressed,
    required Widget child,
    double radius = Corners.med,
    Color background = AppColor.blueLight,
    Color shadowColor = Colors.transparent,
    EdgeInsets? padding,
    Color? clickColor,
    double? height,
    double? width,
    List<BoxShadow>? boxShadow,
  }) =>
      Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow: boxShadow,
        ),
        child: ElevatedButton(
          key: key,
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: clickColor,
            backgroundColor: background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            padding: EdgeInsets.zero,
            shadowColor: shadowColor,
            elevation: 0,
            minimumSize: Size.zero,
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.symmetric(horizontal: Insets.lg, vertical: Insets.med),
            child: child,
          ),
        ),
      );

  static Widget fullColorWithIcon({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
    double radius = Corners.med,
    Color background = AppColor.blueLight,
    Color shadowColor = Colors.transparent,
    EdgeInsets? padding,
    Color? clickColor,
    double? height,
    double? width,
    List<BoxShadow>? boxShadow,
    TextStyle? textStyle,
    Color textColor = AppColor.white,
    bool isRightIcon = false,
    double? iconSize,
  }) =>
      Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow: boxShadow,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: clickColor,
            backgroundColor: background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            padding: EdgeInsets.zero,
            shadowColor: shadowColor,
            elevation: 0,
            minimumSize: Size.zero,
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.symmetric(horizontal: Insets.lg, vertical: Insets.med),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (!isRightIcon)
                  Padding(
                    padding: EdgeInsets.only(right: Insets.med),
                    child: Icon(
                      icon,
                      color: AppColor.white,
                      size: iconSize ?? IconSizes.xs,
                    ),
                  ),
                Text(
                  text,
                  style: textStyle ?? TextStyles.button1.copyWith(color: textColor, height: 0),
                ),
                if (isRightIcon)
                  Padding(
                    padding: EdgeInsets.only(left: Insets.med),
                    child: Icon(
                      icon,
                      color: AppColor.white,
                      size: iconSize ?? IconSizes.xs,
                    ),
                  )
              ],
            ),
          ),
        ),
      );

  static Widget selectDate(
    BuildContext context, {
    Key? key,
    DateTime? initDate,
    DateTime? firstDate,
    DateTime? lastDate,
    required ValueChanged<DateTime?> onPressed,
    EdgeInsets? padding,
    bool withIcon = true,
    Color? textColor,
  }) =>
      withIcon
          ? outlineWithIcon(
              key: key,
              onPressed: () async {
                DateTime handleInitDate = initDate ?? DateTime.now();
                DateTime handleFirstDate = firstDate ?? DateTime(DateTime.now().year - 5);
                DateTime handleLastDate = lastDate ?? DateTime(DateTime.now().year + 5);
                if (initDate == null && firstDate != null && firstDate.isAfter(handleInitDate)) {
                  handleInitDate = firstDate;
                }
                if (initDate == null && lastDate != null && lastDate.isBefore(handleInitDate)) {
                  handleInitDate = lastDate;
                }
                final DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: handleInitDate,
                  firstDate: handleFirstDate,
                  lastDate: handleLastDate,
                );
                if (date == null) return;
                onPressed(date);
              },
              padding: padding ??
                  EdgeInsets.symmetric(
                    vertical: 14.scaleSize,
                    horizontal: 16.scaleSize,
                  ),
              text: initDate.dateStr,
              textStyle: TextStyles.button1.copyWith(
                color: textColor ?? AppColor.black800,
                height: 0,
              ),
              clickColor: AppColor.grey300,
              icon: Icons.calendar_month,
              isRightIcon: true,
            )
          : outline(
              key: key,
              onPressed: () async {
                DateTime handleInitDate = initDate ?? DateTime.now();
                DateTime handleFirstDate = firstDate ?? DateTime(DateTime.now().year - 5);
                DateTime handleLastDate = lastDate ?? DateTime(DateTime.now().year + 5);
                if (initDate == null && firstDate != null && firstDate.isAfter(handleInitDate)) {
                  handleInitDate = firstDate;
                }
                if (initDate == null && lastDate != null && lastDate.isBefore(handleInitDate)) {
                  handleInitDate = lastDate;
                }
                final DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: handleInitDate,
                  firstDate: handleFirstDate,
                  lastDate: handleLastDate,
                );
                if (date == null) return;
                onPressed(date);
              },
              padding: EdgeInsets.symmetric(vertical: 14.scaleSize, horizontal: 16.scaleSize),
              text: initDate.dateStr,
              textStyle: TextStyles.button1.copyWith(
                color: textColor ?? AppColor.black800,
                height: 0,
              ),
              clickColor: AppColor.grey300,
            );

  static Widget selectTime(
    BuildContext context, {
    Key? key,
    TimeOfDay? initTime,
    Color? textColor,
    required ValueChanged<TimeOfDay?> onPressed,
  }) =>
      outlineWithIcon(
        key: key,
        onPressed: () async {
          final TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: initTime!,
          );
          if (time == null) return;
          onPressed(time);
        },
        padding: EdgeInsets.symmetric(vertical: 14.scaleSize, horizontal: 16.scaleSize),
        text: initTime.timeToStr,
        textStyle: TextStyles.button1.copyWith(
          color: textColor ?? AppColor.black800,
          height: 0,
        ),
        clickColor: AppColor.grey300,
        icon: Icons.access_time,
        isRightIcon: true,
      );

  static Widget selectDateAndTime(
    BuildContext context, {
    Key? key,
    String? initText,
    DateTime? initDate,
    DateTime? firstDate,
    DateTime? lastDate,
    Color? textColor,
    EdgeInsets? padding,
    required Function(DateTime?) onPressed,
  }) {
    TimeOfDay? initTime;
    if (initDate != null) {
      initTime = TimeOfDay(hour: initDate.hour, minute: initDate.minute);
    }
    return outline(
      key: key,
      onPressed: () async {
        DateTime? resultSelect = initDate;
        DateTime handleInitDate = initDate ?? DateTime.now();
        DateTime handleFirstDate = firstDate ?? DateTime(DateTime.now().year - 5);
        DateTime handleLastDate = lastDate ?? DateTime(DateTime.now().year + 5);
        if (initDate == null && firstDate != null && firstDate.isAfter(handleInitDate)) {
          handleInitDate = firstDate;
        }
        if (initDate == null && lastDate != null && lastDate.isBefore(handleInitDate)) {
          handleInitDate = lastDate;
        }
        final DateTime? date = await showDatePicker(
          context: context,
          initialDate: handleInitDate,
          firstDate: handleFirstDate,
          lastDate: handleLastDate,
        );
        if (date != null) {
          resultSelect = DateTime(date.year, date.month, date.day);
        }
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: initTime ?? TimeOfDay.now(),
        );
        if (time != null && resultSelect != null) {
          resultSelect = DateTime(
            resultSelect.year,
            resultSelect.month,
            resultSelect.day,
            time.hour,
            time.minute,
          );
        }
        onPressed(resultSelect);
      },
      padding: padding ?? EdgeInsets.symmetric(vertical: 14.scaleSize),
      text: initDate == null
          ? initText ?? '${initDate.dateStr} ${initTime.timeToStr}'
          : '${initDate.dateStr} ${initTime.timeToStr}',
      textStyle: TextStyles.button1.copyWith(
        color: textColor ?? AppColor.black800,
        height: 0,
      ),
      clickColor: AppColor.grey300,
    );
  }
}
