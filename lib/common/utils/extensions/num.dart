import 'package:intl/intl.dart';
import 'package:EMO/common/store/config_store.dart';

import '../utils.dart';

extension NumExtension on num {
  double get scaleSize => ConfigStore.to.scale * this;

  String get toVNDCurrency => "${truncateNumberToString(this)} VND";

  String get toCurrencyStr => truncateNumberToString(this);

  String get toPercent => NumberFormat.percentPattern().format(this);

  double get deviceWidth => ConfigStore.to.deviceWidth * this;

  double get deviceHeight => ConfigStore.to.deviceHeight * this;

  double get K => 1000.0 * this;

  double get M => 1000000.0 * this;

  double get B => 1000000000.0 * this;

  /// Example:
  /// 1.0 -> 1
  /// 2.0000 -> 2
  /// 3.01 -> 3.01
  num getMaxPrecision({int? maxDigits}) {
    if (round() == this) return round().toInt();
    if (maxDigits == null) return num.parse(toString().replaceAll(RegExp(r'([.]*0)(?!.*\d)'), ""));
    return num.parse(
      toStringAsFixed(maxDigits).replaceAll(
        RegExp(r'([.]*0)(?!.*\d)'),
        "",
      ),
    );
  }
}
