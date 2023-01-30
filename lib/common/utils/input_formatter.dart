import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_base/common/utils/utils.dart';

class AppTextInputFormatter {
  AppTextInputFormatter._();

  /// Allow fill

  // eg: allow user only fill 0 -> 9 or . (dot) or , (comma)
  static final digitsWithComma =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'));

  /// Format
  static final phoneNumber = MaskTextInputFormatter(
    mask: "@!## ### ###",
    filter: {
      "@": RegExp(r'0'),
      "!": RegExp(r'[357-9]'),
      "#": RegExp(r'[0-9]'),
    },
    type: MaskAutoCompletionType.lazy,
  );

  static final percent = MaskTextInputFormatter(
    mask: "###",
    type: MaskAutoCompletionType.lazy,
  );

  /// TextEditingController
  static TextEditingController textWithCommaAndDotController(num initNumber) {
    try {
      return TextEditingController(
        text: truncateNumberToString(initNumber),
      );
    } catch (e) {
      return TextEditingController(
        text: initNumber.toString(),
      );
    }
  }

  @Deprecated(
    "It will delete in the future, use [textWithCommaAndDot] instead",
  )
  static final currency = _FormatCurrencyText();

  // eg: 12345678.23456 (String) -> 12,345,678.234 (String)
  static final textWithCommaAndDot = _FormatTextToCommaAndDot();

  /// Reverse
  @Deprecated(
    "It will delete in the future, use [reversedFromCommaAndDotToCurrency] instead",
  )
  static final ValueTransformer<String?> reversedFromCurrency =
      _ReverseFormatCurrencyText();

  // eg: 12,345,678.234 (String) -> 12345678.23456 (double)
  // eg: 12,345.000 (String) = 12345 (int)
  static final ValueTransformer<String?> reversedFromCommaAndDotToNumber =
      _ReversedFromCommaAndDotToNumber();
}

@Deprecated(
  "It will delete in the future, use [_ReversedFromCommaAndDotToCurrency] instead",
)
class _ReverseFormatCurrencyText {
  num? call(String? value) {
    if (value == null || value.isEmpty) return null;
    return num.parse(value.replaceAll('.', '').trim().replaceAll(',', '.'));
  }
}

@Deprecated(
  "It will delete in the future, use [_FormatCurrencyToCommaAndDot] instead",
)
class _FormatCurrencyText implements TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue.copyWith(text: '');

    if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final f = NumberFormat("#,###");
      final number =
          int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(number);
      return TextEditingValue(
        text: newString.replaceAll(',', ' '),
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    }
    return newValue;
  }
}

class _ReversedFromCommaAndDotToNumber {
  num call(String? value) {
    if (value == null || value.isEmpty) return 0;
    return num.parse(value.replaceAll(',', '').trim());
  }
}

class _FormatTextToCommaAndDot implements TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(
        text: '0',
        selection: const TextSelection.collapsed(offset: 1),
      );
    }

    if (newValue.text.length >= 25) return oldValue;

    if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight = newValue.text.length - newValue.selection.end;
      String handleText = newValue.text
          .replaceAll(',', '')
          .replaceFirst('.', '-')
          .replaceAll('.', '')
          .replaceAll('-', '.')
          .trim();
      final splitDotNewText = handleText.split('.');
      if (splitDotNewText[0].isEmpty) splitDotNewText[0] = '0';
      splitDotNewText[0] = truncateNumberToString(
        int.parse(
          splitDotNewText[0].trim(),
        ),
      );
      String newString = splitDotNewText[0];

      bool isThreeZero = false;
      if (splitDotNewText.length >= 2 && splitDotNewText[1].length >= 3) {
        final textAfterDot = splitDotNewText[1].substring(0, 3);
        if (textAfterDot == '000') {
          isThreeZero = true;
        }
        splitDotNewText[1] = double.parse(
          '0.$textAfterDot',
        ).toString().split('.')[1];
      }

      if (splitDotNewText.length >= 2) {
        newString = '${splitDotNewText[0]}.${splitDotNewText[1]}';
      }
      if (isThreeZero) newString = splitDotNewText[0];
      final int newSelection = newString.length - selectionIndexFromTheRight;
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newSelection > 0 ? newSelection : newValue.selection.end,
        ),
      );
    }
    return newValue;
  }
}
