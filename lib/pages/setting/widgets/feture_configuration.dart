import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_base/common/entities/setting_model.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/common/values/values.dart';
import 'package:flutter_base/pages/setting/index.dart';

class FeatureConfigurationWidget extends StatelessWidget {
  const FeatureConfigurationWidget({Key? key}) : super(key: key);

  SettingController get controller => Get.find<SettingController>();

  // Settings? get setting => VendorSessionStore.to.vendorSession?.settings;

  @override
  Widget build(BuildContext context) {
    return SettingTileWidget(
      children: [
        SettingSwitcherWidget(
          title: S.current.Cho_phep_nhan_vien_thay_doi_gia,
          initialValue: AppConfigureStore.to.getAttribute<bool>(AppStorage.$prefAllowChangePrice),
          onChanged: (bool value) {
            controller.setConfigureAttribute(AppStorage.$prefAllowChangePrice, value);
          },
        ),
        SettingSwitcherWidget(
          title: S.current.Cho_phep_nhan_vien_thay_doi_hang_hoa,
          initialValue:
              AppConfigureStore.to.getAttribute<bool>(AppStorage.$prefAllowChangeNameProduct),
          onChanged: (bool value) {
            controller.setConfigureAttribute(AppStorage.$prefAllowChangeNameProduct, value);
          },
        ),
        SettingSwitcherWidget(
          title: S.current.Nhan_du_lieu_tu_thu_ngan_khac,
          initialValue:
              AppConfigureStore.to.getAttribute<bool>(AppStorage.$prefReceiveDataFromOtherCashiers),
          onChanged: (bool value) {
            controller.setConfigureAttribute(AppStorage.$prefReceiveDataFromOtherCashiers, value);
          },
        ),
        SettingSwitcherWidget(
          title: S.current.Mo_cashbox_sau_thanh_toan,
          initialValue:
              AppConfigureStore.to.getAttribute<bool>(AppStorage.$prefOpenCashBoxAfterPay),
          onChanged: (bool value) {
            controller.setConfigureAttribute(AppStorage.$prefOpenCashBoxAfterPay, value);
          },
        ),
        SettingSwitcherWidget(
          title: S.current.Khong_cho_phep_ban_hang_khi_het_ton_kho,
          initialValue:
              AppConfigureStore.to.getAttribute<bool>(AppStorage.$prefStockControlWhenSelling),
          onChanged: (bool value) {
            controller.setConfigureAttribute(AppStorage.$prefStockControlWhenSelling, value);
          },
        ),
        SettingNavigatorWidget(
          title: S.current.Cai_dat_man_hinh_chon_sp,
          icon: Icons.arrow_forward_ios_outlined,
          onTap: () {
            // Todo: Lam sau
            CustomToast.info(msg: S.current.Tinh_nang_dang_phat_trien);
          },
        ),
        SettingBuilder(
            builder: (rebuild) => SettingNavigatorWidget(
                  title: S.current.So_the_cung,
                  subtitle: AppConfigureStore.to.getAttribute(AppStorage.$prefCardNumberCount),
                  icon: Icons.arrow_forward_ios_outlined,
                  onTap: () async {
                    final initData =
                        AppConfigureStore.to.getAttribute(AppStorage.$prefCardNumberCount);

                    final data = await showDialog<String>(
                      context: context,
                      builder: (context) => CardCountDialog(cardCount: initData),
                    );

                    if (data != null) {
                      await controller.setConfigureAttribute(AppStorage.$prefCardNumberCount, data);
                      rebuild();
                    }
                  },
                )),
        SettingBuilder(
          builder: (rebuild) => SettingNavigatorWidget(
            title: S.current.Thiet_lap_VAT,
            icon: Icons.arrow_forward_ios_outlined,
            subtitle: AppConfigureStore.to.getAttribute<int?>(AppStorage.$prefVatMethod) != null
                ? vatTypeMap.values
                    .toList()[AppConfigureStore.to.getAttribute<int?>(AppStorage.$prefVatMethod)!]
                : null,
            onTap: () async {
              final initialValue =
                  AppConfigureStore.to.getAttribute<int?>(AppStorage.$prefVatMethod) != null
                      ? VATConfigData(
                          vatType: VATType.values[
                              AppConfigureStore.to.getAttribute<int?>(AppStorage.$prefVatMethod)!],
                          vatRate:
                              AppConfigureStore.to.getAttribute<double?>(AppStorage.$prefVat) ?? 0,
                        )
                      : null;

              final data = await showDialog<VATConfigData>(
                context: context,
                builder: (context) => VATConfigDialog(data: initialValue),
              );

              if (data != null) {
                await controller.setConfigureAttribute(
                    AppStorage.$prefVatMethod, data.vatType.index);
                if (data.vatRate != null) {
                  await Future.delayed(const Duration(seconds: 4),
                      () => controller.setConfigureAttribute(AppStorage.$prefVat, data.vatRate));
                }
                rebuild();
              }
            },
          ),
        ),
        SettingBuilder(
          builder: (rebuild) => SettingNavigatorWidget(
            title: S.current.Don_vi_tien_te,
            icon: Icons.arrow_forward_ios_outlined,
            subtitle: AppConfigureStore.to.getAttribute<int>(AppStorage.$prefCurrencyUnit) != null
                ? CurrencyType
                    .values[AppConfigureStore.to.getAttribute<int>(AppStorage.$prefCurrencyUnit)!]
                    .title
                : null,
            onTap: () async {
              final initData = AppConfigureStore.to
                          .getAttribute<int>(AppStorage.$prefCurrencyUnit) !=
                      null
                  ? CurrencyType
                      .values[AppConfigureStore.to.getAttribute<int>(AppStorage.$prefCurrencyUnit)!]
                  : null;

              final data = await showDialog<CurrencyType>(
                context: context,
                builder: (context) => CurrencyDialog(currencyType: initData),
              );

              if (data != null) {
                AppConfigureStore.to.setAttribute(AppStorage.$prefCurrencyUnit, data.index);
                rebuild();
              }
            },
          ),
        ),
      ],
    );
  }
}
