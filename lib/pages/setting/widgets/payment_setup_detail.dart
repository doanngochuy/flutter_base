import 'package:EMO/common/entities/setting_model.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/values/constants.dart';
import 'package:EMO/common/values/storage.dart';
import 'package:EMO/pages/setting/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../create_withdraw/index.dart';

class PaymentSetupDetailWidget extends StatelessWidget {
  const PaymentSetupDetailWidget({Key? key}) : super(key: key);

  SettingController get controller => Get.find<SettingController>();

  final $accName = "Tên tài khoản";
  final $accNumber = "Số tài khoản";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SettingTitleWidget(
            title: "TÀI KHOẢN MẶC ĐỊNH",
            icon: Icons.account_balance_wallet_outlined,
          ),
          SettingTileWidget(
            children: [
              SettingBuilder(
                builder: (rebuild) => SettingNavigatorWidget(
                  title: "Phương thức thanh toán",
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
                  title: "Tên ngân hàng",
                  subtitle: AppConstant.mapBankBIN[AppConfigureStore.to.getAttribute<int>(AppStorage.prefKeyBank)],
                  icon: Icons.arrow_forward_ios_outlined,
                  onTap: () async {
                    showConfigBankDialog(
                      context,
                      onSelect: (value) async {
                        await controller.setAttribute(AppStorage.prefKeyBank, value);
                        rebuild();
                      },
                      initBankKey:
                          AppConfigureStore.to.getAttribute<int>(AppStorage.prefKeyBank) ?? 0,
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
