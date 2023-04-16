import 'package:json_annotation/json_annotation.dart';

part 'settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.pascal)
class Settings {
  bool qrCodeEnable;
  String withdrawMethod, bankName, accountNumber, accountName;

  Settings({
    this.qrCodeEnable = false,
    this.withdrawMethod = "",
    this.bankName = "",
    this.accountNumber = "",
    this.accountName = "",
  });

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}