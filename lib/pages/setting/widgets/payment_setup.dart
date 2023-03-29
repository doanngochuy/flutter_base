import 'package:flutter/material.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/utils/extensions/extensions.dart';
import 'package:EMO/pages/setting/payment_setup/view.dart';
import 'package:EMO/pages/setting/widgets/widgets.dart';

class PaymentSetupWidget extends StatelessWidget {
  const PaymentSetupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingTileWidget(
      children: [
        SettingNavigatorWidget(
          title: S.current.Thiet_lap_thanh_toan,
          icon: Icons.arrow_forward_ios_rounded,
          onTap: () => context.pushNavigator(
            const PaymentSetupPage(),
            transitionType: ContextPushTransitionType.rightToLeft,
          ),
        ),
      ],
    );
  }
}
