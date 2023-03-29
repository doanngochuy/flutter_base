import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMO/common/entities/setting_model.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/values/storage.dart';
import 'package:EMO/pages/setting/dialogs/printer_config_dialog.dart';
import 'package:EMO/pages/setting/index.dart';

import 'setting_fragment/setting_fragment.dart';

class PrinterConnectionWidget extends GetView<SettingController> {
  const PrinterConnectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final printerData = [
      SettingNavigatorData(title: S.current.May_in_thu_ngan, key: AppStorage.$prefPrintTypeCashier),
      SettingNavigatorData(title: S.current.May_in_bao_bep_a, key: AppStorage.$prefPrintTypeKitchenA),
      SettingNavigatorData(title: S.current.May_in_bao_bep_b, key: AppStorage.$prefPrintTypeKitchenB),
      SettingNavigatorData(title: S.current.May_in_bao_bep_c, key: AppStorage.$prefPrintTypeKitchenC),
      SettingNavigatorData(title: S.current.May_in_bao_bep_d, key: AppStorage.$prefPrintTypeKitchenD),
      SettingNavigatorData(title: S.current.May_in_bao_pha_che_a, key: AppStorage.$prefPrintTypeBartenderA),
      SettingNavigatorData(title: S.current.May_in_bao_pha_che_b, key: AppStorage.$prefPrintTypeBartenderB),
      SettingNavigatorData(title: S.current.May_in_bao_pha_che_c, key: AppStorage.$prefPrintTypeBartenderC),
      SettingNavigatorData(title: S.current.May_in_bao_pha_che_d, key: AppStorage.$prefPrintTypeBartenderD),
      SettingNavigatorData(title: S.current.May_in_tem, key: AppStorage.$prefPrintTypeTemp),
    ];

    return SettingTileWidget(
      children: printerData
          .map(
            (e) => SettingBuilder(
              builder: (rebuild) {
                final value = AppConfigureStore.to.getAttribute(e.key) != null
                    ? PrinterConfigData.fromJson(AppConfigureStore.to.getAttribute(e.key))
                    : null;
                return SettingNavigatorWidget(
                  title: e.title.tr,
                  icon: Icons.arrow_forward_ios_outlined,
                  subtitle: _getSubtitle(value),
                  onTap: () async {
                    final initData = value != null
                        ? PrinterConfigData(
                            pageWidth: value.pageWidth,
                            ipAddress: value.ipAddress,
                            printMethod: value.printMethod,
                          )
                        : null;
                    final data = await showDialog<PrinterConfigData>(
                      context: context,
                      builder: (context) => PrinterConfigDialog(
                        title: e.title,
                        data: initData,
                        printerType:
                            e.title == S.current.May_in_tem ? PrinterType.stamp : PrinterType.paper,
                      ),
                    );

                    if (data != null) {
                      controller.setConfigureAttribute(e.key, data.toJson());
                      rebuild();
                    }
                  },
                );
              },
            ),
          )
          .toList(),
    );
  }

  String? _getSubtitle(PrinterConfigData? value) => value != null
      ? "${printMethodMap[value.printMethod]} ${value.pageWidth != null && value.pageWidth!.isNotEmpty ? ", size: ${value.pageWidth}mm" : ""} ${value.ipAddress != null && value.ipAddress!.isNotEmpty ? "(${value.ipAddress})" : ""}"
      : null;
}
