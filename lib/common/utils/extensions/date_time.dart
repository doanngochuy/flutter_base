import 'package:intl/intl.dart';
import 'package:EMO/common/generated/l10n.dart';

extension DateTimeExtension on DateTime {
  String differenceFrom(DateTime from, {bool isCompact = true}) {
    var fromTime = from.subtract(const Duration(seconds: 2));
    var duration = difference(fromTime);
    final days = duration.inDays > 0 ? "${duration.inDays} ${S.current.Ngay.toLowerCase()} " : "";
    duration = duration - Duration(days: duration.inDays);
    final hours = duration.inHours > 0 ? "${duration.inHours} ${S.current.Gio.toLowerCase()} " : "";
    duration = duration - Duration(hours: duration.inHours);
    final minutes = duration.inMinutes > 0 && !(days != "" && isCompact)
        ? "${duration.inMinutes} ${S.current.Phut.toLowerCase()} "
        : "";
    duration = duration - Duration(minutes: duration.inMinutes);
    final seconds = duration.inSeconds > 0 && !((days != "" || hours != "") && isCompact)
        ? "${duration.inSeconds} ${S.current.Giay.toLowerCase()} "
        : "";

    return "$days$hours$minutes$seconds";
  }

  String get dayOfWeek => DateFormat('EEEE').format(this);

  /// 2022-07-12T09:37:01.2830000Z ---> 09:37
  String get timeStr => DateFormat('HH:mm').format(this);

  /// 2022-07-12T09:37:01.2830000Z ---> 12/07/2022 09:37
  String get fullDateAndTimeStr => DateFormat('dd/MM/yyyy HH:mm').format(this);

  /// 2022-07-12T09:37:01.2830000Z ---> 12/07 09:37
  String get shortDateAndTimeStr => DateFormat('dd/MM HH:mm').format(this);
}

extension DateTimeOrNullExtention on DateTime? {
  /// 2022-07-12T09:37:01.2830000Z ---> 12/07/2022
  String get dateStr {
    if (this != null) {
      return DateFormat('dd/MM/yyyy').format(this!);
    }
    return 'DD/MM/YYYY';
  }

  String get timeStr {
    if (this != null) {
      return DateFormat('HH:mm').format(this!);
    }
    return 'HH:mm';
  }

  /// 2022-07-12T09:37:01.2830000Z ---> 12/07/2022 09:37
  String get fullDateAndTimeStr {
    if (this != null) {
      return DateFormat('dd/MM/yyyy HH:mm').format(this!);
    }

    return "DD/MM/YYYY HH:mm";
  }
}
