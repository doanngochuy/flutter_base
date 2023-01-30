import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/common/values/values.dart';
import 'package:flutter_base/pages/setting/index.dart';

class SystemConfigurationWidget extends StatelessWidget {
  const SystemConfigurationWidget({Key? key}) : super(key: key);

  SettingController get controller => Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return SettingTileWidget(
      children: [
        SettingSwitcherWidget(
          title: S.current.Hien_thanh_dieu_huong,
          initialValue: AppConfigureStore.to.getAttribute<bool>(AppStorage.$prefShowNavigationBar),
          onChanged: (bool value) {
            controller.setConfigureAttribute<bool>(AppStorage.$prefShowNavigationBar, value);
          },
        ),
        SettingSwitcherWidget(
          title: S.current.Giu_man_hinh_luon_sang,
          initialValue: AppConfigureStore.to.getAttribute<bool>(AppStorage.$prefKeepScreenOn),
          onChanged: (bool value) {
            controller.setConfigureAttribute<bool>(AppStorage.$prefKeepScreenOn, value);
          },
        ),
      ],
    );
  }
}
