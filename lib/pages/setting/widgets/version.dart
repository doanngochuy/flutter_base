import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:EMO/pages/setting/index.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionWidget extends StatelessWidget {
  const VersionWidget({Key? key}) : super(key: key);

  SettingController get controller => Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) => Container(
        color: AppColor.white,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
          horizontal: Insets.sm,
          vertical: 17.scaleSize,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "© 2023 EMO JSC",
                style: TextStyle(color: AppColor.grey600, fontSize: 13),
              ),
            ),
            Text(
              "Version ${snapshot.data?.version ?? ""}",
              style: const TextStyle(color: AppColor.grey600, fontSize: 13),
            ),
            HSpace.med,
            Text(
              "Updated ${snapshot.data?.buildNumber.buildNumberToDateStr() ?? ""}",
              style: const TextStyle(color: AppColor.grey600, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
