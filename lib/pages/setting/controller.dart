import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:flutter_base/common/entities/entities.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/remote/api_service.dart';
import 'package:flutter_base/common/service/service.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/common/utils/utils.dart';
import 'package:flutter_base/common/values/print_model.dart';
import 'package:flutter_base/common/values/values.dart';
import 'package:flutter_base/pages/setting/state.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'model.dart';
import 'values.dart';

class SettingController extends GetxController {
  static SettingController get to => Get.find<SettingController>();
  final state = SettingState();
  final TextEditingController textEditingControllerHtml = TextEditingController();
  String contentHtml = "";
  var printTypeSelect = S.current.Don_hang;
  late WebViewController webViewController;
  final HtmlEditorController htmlEditorController = HtmlEditorController();

  SettingController();

  String orderHtmlDefault = "";
  String printCookDefault = "";
  String partnerDefault = "";
  String voucherDefault = "";
  String onOrderHtml = "";
  String order5880Html = "";
  String orderStockHtml = "";
  String orderA4A5Html = "";
  String paymentVoucherHtml = "";
  String poConfirmationHtml = "";
  String receiptVoucherHtml = "";
  String returnHtml = "";
  String returnToSuppliersHtml = "";
  String temFnbHtml = "";
  String transferHtml = "";
  String jsonCashFlow = "";
  String jsonImportProduct = "";
  String jsonOrder5880 = "";
  String jsonPrintCook = "";
  String jsonReturnToSuppliers = "";
  String jsonTemFnb = "";
  String jsonTemRetail = "";
  String jsonTemPlateMobile = "";
  String jsonTransfer = "";

  @override
  Future<void> onReady() async {
    super.onReady();
    await AppConfigureStore.to.syncData();
    await syncDataFile();
  }

  Future<void> syncDataFile() async {
    if (ConfigStore.to.screenWidth.isDesktop) {
      var resultDesktop = await Future.wait(
        [
          rootBundle.loadString(AssetsPath.$onOrderHtml),
          rootBundle.loadString(AssetsPath.$order5880Html),
          rootBundle.loadString(AssetsPath.$orderStockHtml),
          rootBundle.loadString(AssetsPath.$orderA4A5Html),
          rootBundle.loadString(AssetsPath.$paymentVoucherHtml),
          rootBundle.loadString(AssetsPath.$poConfirmationHtml),
          rootBundle.loadString(AssetsPath.$receiptVoucherHtml),
          rootBundle.loadString(AssetsPath.$returnHtml),
          rootBundle.loadString(AssetsPath.$returnToSuppliersHtml),
          rootBundle.loadString(AssetsPath.$temFnbHtml),
          rootBundle.loadString(AssetsPath.$transferHtml),
          rootBundle.loadString(AssetsPath.$cashFlowJson),
          rootBundle.loadString(AssetsPath.$importProductJson),
          rootBundle.loadString(AssetsPath.$order5880Json),
          rootBundle.loadString(AssetsPath.$printCookJson),
          rootBundle.loadString(AssetsPath.$returnToSuppliersJson),
          rootBundle.loadString(AssetsPath.$temFnbJson),
          rootBundle.loadString(AssetsPath.$temRetailJson),
          rootBundle.loadString(AssetsPath.$templateMobileJson),
          rootBundle.loadString(AssetsPath.$transferJson),
        ],
      );
      onOrderHtml = resultDesktop[0];
      order5880Html = resultDesktop[1];
      orderStockHtml = resultDesktop[2];
      orderA4A5Html = resultDesktop[3];
      paymentVoucherHtml = resultDesktop[4];
      poConfirmationHtml = resultDesktop[5];
      receiptVoucherHtml = resultDesktop[6];
      returnHtml = resultDesktop[7];
      returnToSuppliersHtml = resultDesktop[8];
      temFnbHtml = resultDesktop[9];
      transferHtml = resultDesktop[10];
      jsonCashFlow = resultDesktop[11];
      jsonImportProduct = resultDesktop[12];
      jsonOrder5880 = resultDesktop[13];
      jsonPrintCook = resultDesktop[14];
      jsonReturnToSuppliers = resultDesktop[15];
      jsonTemFnb = resultDesktop[16];
      jsonTemRetail = resultDesktop[17];
      jsonTemPlateMobile = resultDesktop[18];
      jsonTransfer = resultDesktop[19];
    } else {
      var resultMobile = await Future.wait(
        [
          rootBundle.loadString(AssetsPath.$orderHtml),
          rootBundle.loadString(AssetsPath.$printCook),
          rootBundle.loadString(AssetsPath.$partnerHtml),
          rootBundle.loadString(AssetsPath.$voucherHtml)
        ],
      );
      orderHtmlDefault = resultMobile[0];
      printCookDefault = resultMobile[1];
      partnerDefault = resultMobile[2];
      voucherDefault = resultMobile[3];
      dataPrintTemplate[S.current.Don_hang]?.html = orderHtmlDefault;
      dataPrintTemplate[S.current.Bao_che_bien]?.html = printCookDefault;
      dataPrintTemplate[S.current.Doi_tac]?.html = partnerDefault;
      dataPrintTemplate[S.current.Phieu_khuyen_mai]?.html = voucherDefault;
      textEditingControllerHtml.text = orderHtmlDefault;
    }
  }

  Future<bool> updateToRemoteDatabase<T>(String key, T value) async {
    final body = {"Key": key, "Value": value};

    try {
      final result = true; //Call Api update setting
      return result;
    } catch (e) {
      CustomSnackBar.error(title: "Error".tr, message: e.toString());
      return false;
    }
  }

  static const _mappingData = {
    AppStorage.$prefActiveQrCode: "QrCodeEnable",
    AppStorage.$prefMerchantName: "MerchantName",
    AppStorage.$prefMerchantCode: "MerchantCode",
    AppStorage.$prefMerchantNameVT: "VTMerchantName",
    AppStorage.$prefMerchantCodeVT: "VTMerchantCode",
    AppStorage.$prefMerchantCategoryCode: "SmartPOS_MCC",
    AppStorage.$prefAllowPrintPreview: "AllowPrintPreview",
    AppStorage.$prefPrintKitchenAfterSave: "PrintKitchenAfterSave",
    AppStorage.$prefAllowChangePrice: "AllowChangePrice",
    AppStorage.$prefStockControlWhenSelling: "StockControlWhenSelling",
    AppStorage.$prefVat: "VAT",
    AppStorage.$prefVatMethod: "VATMethod",
  };

  Future<bool> handleUpdateData<T>(String key, T value) async {
    final k = _mappingData[key];

    if (k != null) return updateToRemoteDatabase(k, value);

    return true;
  }

  Future<void> setConfigureAttribute<T>(String key, T value) async {
    final isSuccess = await handleUpdateData<T>(key, value);

    isSuccess
        ? AppConfigureStore.to.setAttribute<T>(key, value)
        : CustomSnackBar.error(
            title: S.current.Loi, message: S.current.Cap_nhat_that_bai);
  }

  Future<void> setHtmlWithType() async {
    textEditingControllerHtml.text = (dataPrintTemplate[printTypeSelect]?.html)!;
    contentHtml = textEditingControllerHtml.text;
  }

  Future<void> onSearchPrintTemplate(value) async {
    if (value.isEmpty) {
      state.tempalteKeys.value = PrintCodeMobile.values;
      return;
    }
    var listTmp = [];
    for (var item in PrintCodeMobile.values) {
      if (item.code.contains(value) || item.description.contains(value)) {
        listTmp.add(item);
      }
    }
    state.tempalteKeys.value = [...listTmp];
  }

  setContentHtmlEditor({value, isReset = true}) {
    String content = "";
    switch (value) {
      case TemplateTypeWeb.donHang5880:
        state.tempalteKeyWeb.value = jsonDecode(jsonOrder5880);
        content = order5880Html;
        break;
      case TemplateTypeWeb.donHangA4A5:
        state.tempalteKeyWeb.value = jsonDecode(jsonOrder5880);
        content = order5880Html;
        break;
      case TemplateTypeWeb.donHangMobile:
        state.tempalteKeyWeb.value = jsonDecode(jsonTemPlateMobile);
        content = orderHtmlDefault;
        break;
      case TemplateTypeWeb.temFnb:
        state.tempalteKeyWeb.value = jsonDecode(jsonTemFnb);
        content = temFnbHtml;
        break;
      case TemplateTypeWeb.temFnbMobile:
        state.tempalteKeyWeb.value = jsonDecode(jsonTemFnb);
        break;
      case TemplateTypeWeb.temBanle:
        state.tempalteKeyWeb.value = jsonDecode(jsonTemRetail);
        break;
      case TemplateTypeWeb.datHang:
        state.tempalteKeyWeb.value = jsonDecode(jsonOrder5880);
        content = onOrderHtml;
        break;
      case TemplateTypeWeb.phieuThu:
        state.tempalteKeyWeb.value = jsonDecode(jsonCashFlow);
        content = receiptVoucherHtml;
        break;
      case TemplateTypeWeb.phieuChi:
        state.tempalteKeyWeb.value = jsonDecode(jsonCashFlow);
        content = paymentVoucherHtml;
        break;
      case TemplateTypeWeb.traHang:
        state.tempalteKeyWeb.value = jsonDecode(jsonImportProduct);
        content = returnHtml;
        break;
      case TemplateTypeWeb.nhapHang:
        state.tempalteKeyWeb.value = jsonDecode(jsonImportProduct);
        content = orderStockHtml;
        break;
      case TemplateTypeWeb.nhanHang:
        state.tempalteKeyWeb.value = jsonDecode(jsonImportProduct);
        content = poConfirmationHtml;
        break;
      case TemplateTypeWeb.traHangNCC:
        state.tempalteKeyWeb.value = jsonDecode(jsonReturnToSuppliers);
        content = returnToSuppliersHtml;
        break;
      case TemplateTypeWeb.chuyenHang:
        state.tempalteKeyWeb.value = jsonDecode(jsonTransfer);
        content = transferHtml;
        break;
      case TemplateTypeWeb.inBaoCheBien:
        state.tempalteKeyWeb.value = jsonDecode(jsonPrintCook);
        break;
      case TemplateTypeWeb.inBaoCheBienMobile:
        state.tempalteKeyWeb.value = jsonDecode(jsonPrintCook);
        break;
      default:
        state.tempalteKeyWeb.value = jsonDecode(jsonOrder5880);
        content = order5880Html;
        break;
    }
    if (isReset) {
      htmlEditorController.setText(content);
    }
  }
}
