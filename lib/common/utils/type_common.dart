import 'package:flutter_base/common/utils/utils.dart';

typedef ValueGetterWithInput<K, V> = V Function(K input);
typedef AsyncValueGetterWithInput<K, V> = Future<V> Function(K input);

class ArrangeTime {
  const ArrangeTime({
    this.startTime,
    this.endTime,
  });

  final DateTime? startTime;
  final DateTime? endTime;

  Map<String, String> toShowTime() {
    return {
      'startTime': startTime.dateStr,
      'endTime': endTime.dateStr,
    };
  }

  String toShowTimeStr() {
    return '${startTime.dateStr} - ${endTime.dateStr}';
  }

  ArrangeTime copyWith({
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return ArrangeTime(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  bool isNotEmpty() => startTime != null && endTime != null;
}
