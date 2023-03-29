import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/pages/setting/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SettingMobile extends StatelessWidget {
  const SettingMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.successColor,
      ),
      body: ColoredBox(
        color: AppColor.grey300WithOpacity500,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Insets.med),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SettingTitleWidget(title: S.current.Thanh_toan.toUpperCase(), icon: Icons.payment),
              const PaymentSetupWidget(),
              SettingTitleWidget(
                  title: S.current.Thong_bao.toUpperCase(), icon: Icons.notifications),
              const NotificationWidget(),
              const FeatureConfigurationWidget(),
              VSpace(Insets.med),
            ],
          ),
        ),
      ),
    );
  }
}
