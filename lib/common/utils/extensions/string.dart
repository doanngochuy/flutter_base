import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _vietnameseTranslated =
    "aaaaaaaaaaaaaaaaadeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyd";
const _vietnameseOrigin = 'àáảãạăắằẵặẳâầấậẫẩđèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđ';

extension StringExtension on String {
  String percentEncode() {
    // Do initial percentage encoding of using Uri.encodeComponent()
    String input = Uri.encodeComponent(this);

    // Percentage encode characters ignored by Uri.encodeComponent()
    input = input.replaceAll('-', '%2D');
    input = input.replaceAll('_', '%5F');
    input = input.replaceAll('.', '%2E');
    input = input.replaceAll('!', '%21');
    input = input.replaceAll('~', '%7E');
    input = input.replaceAll('*', '%2A');
    input = input.replaceAll('\'', '%5C');
    input = input.replaceAll('(', '%28');
    input = input.replaceAll(')', '%29');

    return input;
  }

  String get toLatinCharacters {
    var result = this;
    for (var i = 0; i < _vietnameseOrigin.length; ++i) {
      result = result.replaceAll(_vietnameseOrigin[i], _vietnameseTranslated[i]);
    }
    return result;
  }

  String get toMobileFileName => toLatinCharacters.replaceAll(" ", "_");

  String titleWithEllipsis([int maxLength = 15]) {
    if (length > maxLength) return '${substring(0, maxLength)}...';

    return this;
  }

  String toPriceTag() {
    String input = Uri.encodeComponent(this);
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    input = input.replaceAllMapped(reg, (Match match) => '${match[1]},');
    return input;
  }

  /// 2022-07-12T09:37:01.2830000Z ---> DateTime(2022, 7, 12)
  DateTime get toDateTime => DateTime.parse(this);

  TimeOfDay get toTimeOfDay => TimeOfDay.fromDateTime(toDateTime);

  /// 2022-07-12T09:37:01.2830000Z ---> 12/07/2022 09:37
  String get dateTimeStr {
    try {
      return DateFormat("dd/MM/yyyy HH:mm").format(toDateTime);
    } catch (e) {
      return '';
    }
  }

  double get parseSafeDouble => double.tryParse(replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;

  int get parseSafeInt => int.tryParse(replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
}
