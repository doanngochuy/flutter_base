import 'package:json_annotation/json_annotation.dart';

part 'settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.pascal)
class Settings {
  bool differentiatedproductsbyWarehouse, differentPriceByWarehouse;
  double valueToPoint, pointToValue;
  bool excludeOrderDiscount, excludeProductDiscount;
  @JsonKey(name: 'VAT')
  double vat;
  @JsonKey(name: 'VATMethod')
  int vatMethod;
  bool allowChangePrice,
      allowChangeSalespeople,
      limitTransactionTime,
      stockControlWhenSelling,
      allowPrintPreview;
  int costMethod;
  bool returnHistory, changeTimer;
  int notAllowUpdateOrder, electronicWeightScaleCodeLength;
  String electronicWeightScaleCode, electronicWeightScaleCom, iPFilterConfiguration;
  int blockOfTimeToUseService, pRP80DPI, a4DPI;
  bool screenForKitchen;
  int pRPKitchen80DPI;
  String receiptPrinterName,
      kitchenAPrinterName,
      kitchenBPrinterName,
      kitchenCPrinterName,
      kitchenDPrinterName,
      bartenderAPrinterName,
      bartenderBPrinterName,
      bartenderCPrinterName,
      bartenderDPrinterName,
      barCodePrinterName;
  bool printKitchenAfterSave;
  String poleDisplay;
  int poleDisplayBaudRate;
  bool qrCodeEnable;
  String merchantCode, merchantName, vTMerchantCode, vTMerchantName, vTAccessCode, vTHashKey;
  bool selfOrderPrepayment, selfOrderEnable;
  String selfOrderIP, smartPOSMcc, secondMonitor, mapObjects, productPositions;

  Settings({
    this.differentiatedproductsbyWarehouse = false,
    this.differentPriceByWarehouse = false,
    this.valueToPoint = 0,
    this.pointToValue = 0,
    this.excludeOrderDiscount = false,
    this.excludeProductDiscount = false,
    this.vat = 0,
    this.vatMethod = 0,
    this.allowChangePrice = false,
    this.allowChangeSalespeople = false,
    this.limitTransactionTime = false,
    this.stockControlWhenSelling = false,
    this.allowPrintPreview = false,
    this.costMethod = 0,
    this.returnHistory = false,
    this.changeTimer = false,
    this.notAllowUpdateOrder = 0,
    this.electronicWeightScaleCodeLength = 0,
    this.electronicWeightScaleCode = "",
    this.electronicWeightScaleCom = "",
    this.iPFilterConfiguration = "",
    this.blockOfTimeToUseService = 0,
    this.pRP80DPI = 0,
    this.a4DPI = 0,
    this.screenForKitchen = false,
    this.pRPKitchen80DPI = 0,
    this.receiptPrinterName = "",
    this.kitchenAPrinterName = "",
    this.kitchenBPrinterName = "",
    this.kitchenCPrinterName = "",
    this.kitchenDPrinterName = "",
    this.bartenderAPrinterName = "",
    this.bartenderBPrinterName = "",
    this.bartenderCPrinterName = "",
    this.bartenderDPrinterName = "",
    this.barCodePrinterName = "",
    this.printKitchenAfterSave = false,
    this.poleDisplay = "",
    this.poleDisplayBaudRate = 0,
    this.qrCodeEnable = false,
    this.merchantCode = "",
    this.merchantName = "",
    this.vTMerchantCode = "",
    this.vTMerchantName = "",
    this.vTAccessCode = "",
    this.vTHashKey = "",
    this.selfOrderPrepayment = false,
    this.selfOrderEnable = false,
    this.selfOrderIP = "",
    this.smartPOSMcc = "",
    this.secondMonitor = "",
    this.mapObjects = "",
    this.productPositions = "",
  });

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}