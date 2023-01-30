import 'package:flutter/material.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/pages/setting/widgets/widgets.dart';

class SettingWeb extends StatelessWidget {
  const SettingWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey300,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Insets.lg),
        physics: const BouncingScrollPhysics(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingTitleWidget(title: S.current.Thiet_lap_ip.toUpperCase(), icon: Icons.flag),
                  const IPSetupWidget(),
                  SettingTitleWidget(title: S.current.Thanh_toan.toUpperCase(), icon: Icons.payment),
                  const PaymentSetupWidget(),
                  SettingTitleWidget(
                    title: S.current.Thong_bao.toUpperCase(),
                    icon: Icons.notifications,
                  ),
                  const NotificationWidget(),
                  SettingTitleWidget(
                    title: S.current.Ket_noi_may_in.toUpperCase(),
                    icon: Icons.settings,
                  ),
                  const PrinterConnectionWidget(),
                  VSpace(Insets.lg),
                ],
              ),
            ),
            HSpace.lg,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingTitleWidget(
                    title: S.current.Cai_dat_may_in.toUpperCase(),
                    icon: Icons.print,
                  ),
                  SettingTitleWidget(
                    title: S.current.Thiet_lap_tinh_nang.toUpperCase(),
                    icon: Icons.tune,
                  ),
                  const FeatureConfigurationWidget(),
                  SettingTitleWidget(
                    title: S.current.Thiet_lap_he_thong.toUpperCase(),
                    icon: Icons.settings_applications_outlined,
                  ),
                  const SystemConfigurationWidget(),
                  VSpace(Insets.lg),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
