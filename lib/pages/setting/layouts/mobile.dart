import 'package:flutter/material.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/pages/setting/widgets/widgets.dart';

class SettingMobile extends StatelessWidget {
  const SettingMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColor.grey300WithOpacity500,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Insets.med),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SettingTitleWidget(title: S.current.Thiet_lap_ip.toUpperCase(), icon: Icons.flag),
            const IPSetupWidget(),
            SettingTitleWidget(title: S.current.Thanh_toan.toUpperCase(), icon: Icons.payment),
            const PaymentSetupWidget(),
            SettingTitleWidget(title: S.current.Thong_bao.toUpperCase(), icon: Icons.notifications),
            const NotificationWidget(),
            SettingTitleWidget(title: S.current.Ket_noi_may_in.toUpperCase(), icon: Icons.settings),
            const PrinterConnectionWidget(),
            SettingTitleWidget(title: S.current.Cai_dat_may_in.toUpperCase(), icon: Icons.print),
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
            VSpace(Insets.med),
          ],
        ),
      ),
    );
  }
}
