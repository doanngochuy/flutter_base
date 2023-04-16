import 'package:EMO/common/entities/setting_model.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/values/storage.dart';
import 'package:EMO/pages/setting/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../create_withdraw/index.dart';

class PaymentSetupDetailWidget extends StatelessWidget {
  const PaymentSetupDetailWidget({Key? key}) : super(key: key);

  SettingController get controller => Get.find<SettingController>();

  final $paymentMethod = "Phương thức thanh toán";
  final $bankName = "Tên ngân hàng";
  final $accName = "Tên tài khoản";
  final $accNumber = "Số tài khoản";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SettingTileWidget(
            children: [
              SettingSwitcherWidget(
                initialValue: AppConfigureStore.to.getAttribute(AppStorage.prefActiveQrCode),
                onChanged: (value) {
                  controller.setAttribute(AppStorage.prefActiveQrCode, value);
                },
                title: S.current.Kich_hoat_thanh_toan_qua_QR,
              ),
            ],
          ),
          const SettingTitleWidget(
            title: "TÀI KHOẢN MẶC ĐỊNH",
            icon: Icons.account_balance_wallet_outlined,
          ),
          SettingTileWidget(
            children: [
              SettingBuilder(
                builder: (rebuild) => SettingNavigatorWidget(
                  title: $paymentMethod,
                  subtitle:
                      AppConfigureStore.to.getAttribute<String>(AppStorage.prefWithdrawMethod),
                  icon: Icons.arrow_forward_ios_outlined,
                  onTap: () async {
                    showWithdrawMethodDialog(
                      context,
                      onSelect: (value) async {
                        await controller.setAttribute(AppStorage.prefWithdrawMethod, value);
                        rebuild();
                      },
                      paymentMethods: WithdrawStore.to.withdrawMethods,
                      initPaymentMethod: AppConfigureStore.to
                              .getAttribute<String>(AppStorage.prefWithdrawMethod) ??
                          '',
                    );
                  },
                ),
              ),
              SettingBuilder(
                builder: (rebuild) => SettingNavigatorWidget(
                  title: $bankName,
                  subtitle: AppConfigureStore.to.getAttribute<String>(AppStorage.prefNameBank),
                  icon: Icons.arrow_forward_ios_outlined,
                  onTap: () async {
                    showBankDialog(
                      context,
                      onSelect: (value) async {
                        await controller.setAttribute(AppStorage.prefNameBank, value);
                        rebuild();
                      },
                      paymentMethods: WithdrawStore.to.bankNames,
                      initPaymentMethod:
                          AppConfigureStore.to.getAttribute<String>(AppStorage.prefNameBank) ?? '',
                    );
                  },
                ),
              ),
              SettingBuilder(
                builder: (rebuild) => SettingNavigatorWidget(
                  title: $accName,
                  subtitle: AppConfigureStore.to.getAttribute<String>(AppStorage.prefNameAcc),
                  icon: Icons.arrow_forward_ios_outlined,
                  onTap: () async {
                    final data = await showDialog<String>(
                      context: context,
                      builder: (context) => FormFillPaymentDialog(
                        merchantAttributeData: MerchantAttributeData(
                          attribute: $accName,
                          value: AppConfigureStore.to.getAttribute<String>(AppStorage.prefNameAcc),
                          merchant: $accName,
                        ),
                      ),
                    );

                    if (data != null) {
                      await controller.setAttribute(AppStorage.prefNameAcc, data);
                      rebuild();
                    }
                  },
                ),
              ),
              SettingBuilder(
                builder: (rebuild) => SettingNavigatorWidget(
                  title: $accNumber,
                  subtitle: AppConfigureStore.to.getAttribute<String>(AppStorage.prefNumberAcc),
                  icon: Icons.arrow_forward_ios_outlined,
                  onTap: () async {
                    final data = await showDialog<String>(
                      context: context,
                      builder: (context) => FormFillPaymentDialog(
                        merchantAttributeData: MerchantAttributeData(
                          attribute: $accNumber,
                          value:
                              AppConfigureStore.to.getAttribute<String>(AppStorage.prefNumberAcc),
                          merchant: $accNumber,
                        ),
                      ),
                    );

                    if (data != null) {
                      await controller.setAttribute(AppStorage.prefNumberAcc, data);
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
