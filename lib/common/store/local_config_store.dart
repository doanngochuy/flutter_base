import 'dart:convert';

import 'package:flutter_base/common/di/injector.dart';
import 'package:flutter_base/common/local/prefs/prefs_sevice.dart';
import 'package:flutter_base/common/values/storage.dart';

import '../entities/entities.dart';

abstract class AppConfigureStore {
  static AppConfigureStore get to => AppInjector.injector<AppConfigureStore>();

  Map<String, dynamic> get configure;

  Settings get settings;

  Future<void> syncData();

  void setAttribute<T>(String key, T value);

  T? getAttribute<T>(String key);

  void clear();
}

class AppConfigureStoreImpl implements AppConfigureStore {
  var _configure = <String, dynamic>{};
  var _settings = Settings();

  @override
  Map<String, dynamic> get configure => _configure;

  @override
  Settings get settings => _settings;

  AppConfigureStoreImpl() {
    final value = PrefsService.to.getString(AppStorage.$prefLocalConfigStore);
    final val = PrefsService.to.getString(AppStorage.storageVendorSession);
    if (value.isNotEmpty) {
      _configure = {
        ...jsonDecode(value),
        ..._mapRemoteToLocal(_settings),
      };
    }
  }

  @override
  Future<void> syncData() async {

    _settings = settings;
    _configure = {
      ..._configure,
      ..._mapRemoteToLocal(settings),
    };
  }

  Map<String, dynamic> _mapRemoteToLocal(Settings settings) => {
        // Payment
        AppStorage.$prefActiveQrCode: settings.qrCodeEnable,
        AppStorage.$prefMerchantName: settings.merchantName,
        AppStorage.$prefMerchantCode: settings.merchantCode,
        AppStorage.$prefMerchantNameVT: settings.vTMerchantName,
        AppStorage.$prefMerchantCodeVT: settings.vTMerchantCode,
        // Printing
        AppStorage.$prefAllowPrintPreview: settings.allowPrintPreview,
        AppStorage.$prefPrintKitchenAfterSave: settings.printKitchenAfterSave,
        // Feature Config
        AppStorage.$prefAllowChangePrice: settings.allowChangePrice,
        AppStorage.$prefStockControlWhenSelling: settings.stockControlWhenSelling,
        AppStorage.$prefVat: settings.vat,
        AppStorage.$prefVatMethod: settings.vatMethod,
        // System
      };

  @override
  void setAttribute<T>(String key, T value) {
    _configure[key] = value;
    PrefsService.to.setString(AppStorage.$prefLocalConfigStore, jsonEncode(_configure));
  }

  @override
  T? getAttribute<T>(String key) {
    if (_configure.containsKey(key)) {
      return _configure[key] as T;
    }
    return null;
  }

  @override
  void clear() {
    _configure.clear();
    PrefsService.to.remove(AppStorage.$prefLocalConfigStore);
  }
}
