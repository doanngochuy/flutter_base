import 'package:flutter/material.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/utils/utils.dart';
import 'package:flutter_base/pages/setting/widgets/widgets.dart';

import '../ip_setup/index.dart';

class IPSetupWidget extends StatelessWidget {
  const IPSetupWidget({Key? key}) : super(key: key);

  void _handleNextToIPSetup(BuildContext context) => context.pushNavigator(
        const IpSetupPage(),
        transitionType: ContextPushTransitionType.rightToLeft,
      );

  @override
  Widget build(BuildContext context) {
    return SettingTileWidget(
      children: [
        SettingNavigatorWidget(
          title: S.current.Thiet_lap_ip,
          icon: Icons.arrow_forward_ios_rounded,
          onTap: () => _handleNextToIPSetup(context),
        ),
      ],
    );
  }
}
