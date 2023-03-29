import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/store/local_config_store.dart';
import 'package:EMO/common/values/storage.dart';
import 'package:EMO/pages/setting/dialogs/form_fill_payment_dialog.dart';
import 'package:EMO/pages/setting/index.dart';
import 'package:EMO/common/entities/setting_model.dart';
import 'package:EMO/pages/setting/widgets/widgets.dart';

class PaymentSetupDetailWidget extends StatelessWidget {
  const PaymentSetupDetailWidget({Key? key}) : super(key: key);

  SettingController get controller => Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SettingTileWidget(
            children: [
              SettingSwitcherWidget(
                initialValue: AppConfigureStore.to.getAttribute(AppStorage.$prefActiveQrCode),
                onChanged: (value) {
                  controller.setConfigureAttribute(AppStorage.$prefActiveQrCode, value);
                },
                title: S.current.Kich_hoat_thanh_toan_qua_QR,
              ),
              SettingSwitcherWidget(
                initialValue: AppConfigureStore.to.getAttribute(AppStorage.$prefPrintBeforeSuccessPayment),
                onChanged: (value) {
                  controller.setConfigureAttribute(AppStorage.$prefPrintBeforeSuccessPayment, value);
                },
                title: S.current.In_hoa_don_truoc_khi_thanh_toan_QR,
              ),
            ],
          ),
          SettingTitleWidget(
            title: S.current.Thanh_toan_VNPAY,
            icon: Icons.qr_code,
          ),
          SettingTileWidget(
            children: [
              SettingBuilder(
                builder: (rebuild) => SettingNavigatorWidget(
                  title: "Merchant Code",
                  subtitle: AppConfigureStore.to.getAttribute<String>(AppStorage.$prefMerchantCode),
                  icon: Icons.arrow_forward_ios_outlined,
                  onTap: () async {
                    final data = await showDialog<String>(
                      context: context,
                      builder: (context) => FormFillPaymentDialog(
                        merchantAttributeData: MerchantAttributeData(
                          attribute: 'Merchant Code',
                          value: AppConfigureStore.to.getAttribute<String>(AppStorage.$prefMerchantCode),
                          merchant: S.current.Thanh_toan_VNPAY,
                        ),
                      ),
                    );

                    if (data != null) {
                      await controller.setConfigureAttribute(AppStorage.$prefMerchantCode, data);
                      rebuild();
                    }
                  },
                ),
              ),
              SettingBuilder(
                builder: (rebuild) => SettingNavigatorWidget(
                  title: "Merchant Name",
                  subtitle: AppConfigureStore.to.getAttribute<String>(AppStorage.$prefMerchantName),
                  icon: Icons.arrow_forward_ios_outlined,
                  onTap: () async {
                    final data = await showDialog<String>(
                      context: context,
                      builder: (context) => FormFillPaymentDialog(
                        merchantAttributeData: MerchantAttributeData(
                          attribute: 'Merchant Name',
                          value: AppConfigureStore.to.getAttribute<String>(AppStorage.$prefMerchantName),
                          merchant: S.current.Thanh_toan_VNPAY,
                        ),
                      ),
                    );

                    if (data != null) {
                      await controller.setConfigureAttribute(AppStorage.$prefMerchantName, data);
                      rebuild();
                    }
                  },
                ),
              ),
              SettingBuilder(
                builder: (rebuild) => SettingNavigatorWidget(
                  title: "Merchant Category Name",
                  subtitle: AppConfigureStore.to.getAttribute<String>(AppStorage.$prefMerchantCategoryCode),
                  icon: Icons.arrow_forward_ios_outlined,
                  onTap: () async {
                    final data = await showDialog<String>(
                      context: context,
                      builder: (context) => FormFillPaymentDialog(
                        merchantAttributeData: MerchantAttributeData(
                          attribute: 'Merchant Category Name',
                          value:
                              AppConfigureStore.to.getAttribute<String>(AppStorage.$prefMerchantCategoryCode) ?? '',
                          merchant: S.current.Thanh_toan_VNPAY,
                        ),
                      ),
                    );

                    if (data != null) {
                      await controller.setConfigureAttribute(AppStorage.$prefMerchantCategoryCode, data);
                      rebuild();
                    }
                  },
                ),
              ),
            ],
          ),
          SettingTitleWidget(
            title: S.current.Thanh_toan_ViettelPay,
            icon: Icons.qr_code,
          ),
          SettingTileWidget(
            children: [
              SettingBuilder(
                  builder: (rebuild) => SettingNavigatorWidget(
                        title: "Merchant Code",
                        subtitle: AppConfigureStore.to.getAttribute<String>(AppStorage.$prefMerchantCodeVT),
                        icon: Icons.arrow_forward_ios_outlined,
                        onTap: () async {
                          final data = await showDialog<String>(
                            context: context,
                            builder: (context) => FormFillPaymentDialog(
                              merchantAttributeData: MerchantAttributeData(
                                attribute: 'Merchant Code',
                                value:
                                    AppConfigureStore.to.getAttribute<String>(AppStorage.$prefMerchantCodeVT),
                                merchant: S.current.Thanh_toan_ViettelPay,
                              ),
                            ),
                          );

                          if (data != null) {
                            await controller.setConfigureAttribute(AppStorage.$prefMerchantCodeVT, data);
                            rebuild();
                          }
                        },
                      )),
              SettingBuilder(
                builder: (rebuild) => SettingNavigatorWidget(
                  title: "Merchant Name",
                  subtitle: AppConfigureStore.to.getAttribute<String>(AppStorage.$prefMerchantNameVT),
                  icon: Icons.arrow_forward_ios_outlined,
                  onTap: () async {
                    final data = await showDialog<String>(
                      context: context,
                      builder: (context) => FormFillPaymentDialog(
                        merchantAttributeData: MerchantAttributeData(
                          attribute: 'Merchant Name',
                          value: AppConfigureStore.to.getAttribute<String>(AppStorage.$prefMerchantNameVT),
                          merchant: S.current.Thanh_toan_ViettelPay,
                        ),
                      ),
                    );

                    if (data != null) {
                      await controller.setConfigureAttribute(AppStorage.$prefMerchantNameVT, data);
                      rebuild();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
