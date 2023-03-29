import 'package:flutter/material.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';

import '../index.dart';

class SettingWithSectionData {
  final String title;
  final IconData icon;
  final Widget widget;

  const SettingWithSectionData({
    required this.title,
    required this.icon,
    required this.widget,
  });
}

class SettingTablet extends StatefulWidget {
  const SettingTablet({Key? key}) : super(key: key);

  @override
  State<SettingTablet> createState() => _SettingTabletState();
}

class _SettingTabletState extends State<SettingTablet> {
  var _index = 0;

  final listSetting = [
    SettingWithSectionData(
      title: S.current.Thiet_lap_ip,
      icon: Icons.flag,
      widget: const IpSetupPage(
        isShowDetail: true,
      ),
    ),
    SettingWithSectionData(
      title: S.current.Thiet_lap_thanh_toan,
      icon: Icons.payment,
      widget: const PaymentSetupDetailWidget(),
    ),
    SettingWithSectionData(
      title: S.current.Thong_bao,
      icon: Icons.notifications,
      widget: const NotificationWidget(),
    ),
    SettingWithSectionData(
      title: S.current.Ket_noi_may_in,
      icon: Icons.settings,
      widget: const PrinterConnectionWidget(),
    ),
    SettingWithSectionData(
      title: S.current.Thiet_lap_tinh_nang,
      icon: Icons.tune,
      widget: const FeatureConfigurationWidget(),
    ),
    SettingWithSectionData(
      title: S.current.Thiet_lap_he_thong,
      icon: Icons.settings_applications_outlined,
      widget: const SystemConfigurationWidget(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey300,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    VSpace(Insets.med),
                    ...listSetting.asMap().entries.map(
                          (e) => SettingNavigatorWidget(
                            title: e.value.title.toUpperCase(),
                            icon: Icons.arrow_forward_ios_outlined,
                            leadingIcon: e.value.icon,
                            selected: _index == e.key,
                            backgroundColor: AppColor.grey300,
                            selectedColor: AppColor.orange,
                            onTap: () => setState(
                              () => _index = e.key,
                            ),
                          ),
                        ),
                    VSpace(Insets.med),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.lg),
                child: listSetting[_index].widget,
              ),
            ),
          )
        ],
      ),
    );
  }
}
