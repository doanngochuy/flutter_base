import 'dart:convert';

import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:EMO/common/values/constants.dart';
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'withdraw.g.dart';

enum WithdrawStatus {
  @JsonValue('requested')
  requested,
  @JsonValue('transferred')
  transferred;

  String getTitle() {
    switch (this) {
      case WithdrawStatus.requested:
        return S.current.Dang_cho;
      case WithdrawStatus.transferred:
        return S.current.Hoan_thanh;
    }
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Withdraw {
  final int id;
  final String description;
  final String reply;
  final String urlClue;
  final String imageClue;
  final int money;
  final String withdrawMethod;
  final int bankKey;
  final String numberAccount;
  final String accountName;
  final WithdrawStatus? status;
  final int userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Withdraw({
    this.id = 0,
    this.description = "",
    this.reply = "",
    this.urlClue = "",
    this.imageClue = "",
    this.money = 0,
    this.withdrawMethod = "",
    this.bankKey = 0,
    this.numberAccount = "",
    this.accountName = "",
    this.status = WithdrawStatus.requested,
    this.userId = 0,
    this.createdAt,
    this.updatedAt,
  });

  String get code => "E${createdAt?.timeIntDay}-$id";

  String get bankName => AppConstant.mapBankBIN[bankKey] ?? "";

  String get bankShortName => bankName.split(")").elementAtOrNull(0)?.replaceAll("(", "") ?? "";

  factory Withdraw.fromJson(Map<String, dynamic> json) => _$WithdrawFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawToJson(this);

  @override
  String toString() => jsonEncode(this).toString();
}
