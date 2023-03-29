import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMO/common/entities/setting_model.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/values/values.dart';
import 'package:EMO/pages/setting/index.dart';

class FeatureConfigurationWidget extends StatelessWidget {
  const FeatureConfigurationWidget({Key? key}) : super(key: key);

  SettingController get controller => Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return SettingTileWidget(
      children: [
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
