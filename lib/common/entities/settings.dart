import 'package:json_annotation/json_annotation.dart';

part 'settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.pascal)
class Settings {
  bool qrCodeEnable;
  String withdrawMethod, accountNumber, accountName;
  int bankKey;

  Settings({
    this.qrCodeEnable = false,
    this.withdrawMethod = "",
    this.bankKey = 0,
    this.accountNumber = "",
    this.accountName = "",
  });

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}