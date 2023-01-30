import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_base/common/generated/l10n.dart';

part 'setting_model.g.dart';

class SettingSwitcherData {
  final String title;
  final String? apiUrl;
  bool value;

  SettingSwitcherData({
    required this.title,
    this.apiUrl,
    this.value = false,
  });
}

class SettingNavigatorData {
  final String title;
  final String key;

  SettingNavigatorData({
    required this.title,
    required this.key,
  });
}

class MerchantAttributeData<T> {
  final String merchant;
  final String attribute;
  final T? value;

  MerchantAttributeData({
    required this.merchant,
    required this.attribute,
    this.value,
  });
}

enum PrintMethod {
  // Không in
  none,
  // In Sunmi
  sunmi,
  // In qua bluetooth
  bluetooth,
  // in qua usb
  usb,
  // in qua mạng lan
  network;
}

final printMethodMap = {
  PrintMethod.none: S.current.Khong_in,
  PrintMethod.sunmi: S.current.In_sunmi,
  PrintMethod.bluetooth: S.current.In_bluetooth,
  PrintMethod.usb: S.current.In_usb,
  PrintMethod.network: S.current.In_qua_mang_lan,
};

enum PrinterType {
  // Máy in giấy
  paper,
  // Máy in tem
  stamp,
}

enum VATType {
  // VAT tính theo tổng giá trị đơn hàng
  total,
  // VAT tính theo từng sản phẩm
  product,
  // Giá bán đã bao gồm VAT
  include;
}

final vatTypeMap = {
  VATType.total: S.current.VAT_tinh_theo_tong_gia_tri_don_hang,
  VATType.product: S.current.VAT_tinh_theo_tung_san_pham,
  VATType.include: S.current.Gia_ban_da_bao_gom_VAT,
};

enum CurrencyType {
  // VND
  vnd("VND"),
  // USD
  usd("USD");

  final String title;

  const CurrencyType(this.title);
}

@JsonSerializable(explicitToJson: true)
class StoreInfoData {
  final String storeName;
  final String storeAddress;
  final String storePhone;
  final String footer;
  final List<String> banners;
  final List<String> slideshows;

  StoreInfoData({
    required this.storeName,
    required this.storeAddress,
    required this.storePhone,
    required this.footer,
    this.banners = const [],
    this.slideshows = const [],
  });

  factory StoreInfoData.fromJson(Map<String, dynamic> json) => _$StoreInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$StoreInfoDataToJson(this);

  @override
  String toString() {
    return 'StoreInfoData{storeName: $storeName, storeAddress: $storeAddress, storePhone: $storePhone, footer: $footer, banners: $banners, slideshows: $slideshows}';
  }
}

@JsonSerializable(explicitToJson: true)
class PrinterConfigData {
  final String? pageWidth;
  final String? ipAddress;
  final PrintMethod printMethod;

  const PrinterConfigData({
    required this.pageWidth,
    required this.ipAddress,
    required this.printMethod,
  });

  factory PrinterConfigData.fromJson(Map<String, dynamic> json) =>
      _$PrinterConfigDataFromJson(json);

  Map<String, dynamic> toJson() => _$PrinterConfigDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VATConfigData {
  final num? vatRate;
  final VATType vatType;

  VATConfigData({required this.vatRate, required this.vatType});

  factory VATConfigData.fromJson(Map<String, dynamic> json) => _$VATConfigDataFromJson(json);

  Map<String, dynamic> toJson() => _$VATConfigDataToJson(this);

  @override
  String toString() {
    return 'VATConfigData{vatRate: $vatRate, vatType: $vatType}';
  }
}
