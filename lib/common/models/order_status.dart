import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_base/common/generated/l10n.dart';

enum OrderStatus {
  @JsonValue(0)
  pending,
  @JsonValue(1)
  order,
  @JsonValue(2)
  done,
  @JsonValue(3)
  cancel;

  const OrderStatus();

  String get getNameStatus {
    switch (this) {
      case pending:
        return S.current.Dang_xu_ly;
      case done:
        return S.current.Hoan_thanh;
      case cancel:
        return S.current.Huy;
      case order:
        return S.current.Dat_hang;
    }
  }

  int get getValueStatus {
    switch (this) {
      case pending:
        return 0;
      case done:
        return 2;
      case cancel:
        return 3;
      case order:
        return 1;
    }
  }

  static List<OrderStatus> get allStatus => [
        OrderStatus.order,
        OrderStatus.done,
        OrderStatus.cancel,
        OrderStatus.pending,
      ];
}
