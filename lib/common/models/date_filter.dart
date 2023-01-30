import 'package:flutter_base/common/generated/l10n.dart';

enum DateTimeFilter {
  // Toàn thời gian
  allTime(),
  // Hôm nay
  today("today"),
  // Hôm qua
  yesterday("yesterday"),
  // Bảy ngày trước
  sevenDays("7days"),
  // Tháng này
  thisMonth("month"),
  // Tháng trước
  lastMonth("lastmonth"),
  // Lựa chọn khác
  custom();

  final String? value;

  const DateTimeFilter([this.value]);

  String get title {
    switch (this) {
      case DateTimeFilter.allTime:
        return S.current.Toan_thoi_gian;
      case DateTimeFilter.today:
        return S.current.Hom_nay;
      case DateTimeFilter.yesterday:
        return S.current.Hom_qua;
      case DateTimeFilter.sevenDays:
        return S.current.Bay_ngay_truoc;
      case DateTimeFilter.thisMonth:
        return S.current.Thang_nay;
      case DateTimeFilter.lastMonth:
        return S.current.Thang_truoc;
      case DateTimeFilter.custom:
        return S.current.Lua_chon_khac;
    }
  }
}
