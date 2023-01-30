import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/common/utils/utils.dart';

@Deprecated(
  "It will delete in the future",
)
Widget buttonSelectDateAndTime(
  BuildContext context, {
  Key? key,
  DateTime? initDate,
  required Function(DateTime?) onPressed,
}) {
  TimeOfDay? initTime;
  if (initDate != null) {
    initTime = TimeOfDay(hour: initDate.hour, minute: initDate.minute);
  }
  return CustomButton.outline(
    key: key,
    onPressed: () async {
      DateTime? resultSelect = initDate;
      final DateTime? date = await showDatePicker(
        context: context,
        initialDate: initDate ?? DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
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
    padding: EdgeInsets.symmetric(vertical: 14.scaleSize),
    text: '${initDate.dateStr} ${initTime.timeToStr}',
    textStyle: TextStyles.button1.copyWith(
      color: AppColor.black800,
      height: 0,
    ),
    clickColor: AppColor.grey300,
  );
}

@Deprecated(
  "It will delete in the future, use [CustomButton.selectDate] from theme",
)
Widget buttonSelectDate(
  BuildContext context, {
  Key? key,
  DateTime? initDate,
  required ValueChanged<DateTime?> onPressed,
}) {
  return CustomButton.outline(
    key: key,
    onPressed: () async {
      final DateTime? date = await showDatePicker(
        context: context,
        initialDate: initDate ?? DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
      );
      if (date == null) return;
      onPressed(date);
    },
    padding: EdgeInsets.symmetric(vertical: 14.scaleSize),
    text: initDate.dateStr,
    textStyle: TextStyles.button1.copyWith(
      color: AppColor.black800,
      height: 0,
    ),
    clickColor: AppColor.grey300,
  );
}

@Deprecated(
  "It will delete in the future",
)
Widget buttonSelectTime(
  BuildContext context, {
  Key? key,
  TimeOfDay? initTime,
  required Function(TimeOfDay?) onPressed,
}) {
  return CustomButton.outline(
    key: key,
    onPressed: () async {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: initTime!,
      );
      if (time == null) return;
      onPressed(time);
    },
    padding: EdgeInsets.symmetric(vertical: 14.scaleSize),
    text: initTime.timeToStr,
    textStyle: TextStyles.button1.copyWith(
      color: AppColor.black800,
      height: 0,
    ),
    clickColor: AppColor.grey300,
  );
}
