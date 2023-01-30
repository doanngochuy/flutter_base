import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/common/utils/utils.dart';
import 'package:flutter_base/pages/setting/controller.dart';

import 'layouts/layouts.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Widget _renderUI(BuildContext context) {
    if (kIsWeb) {
      if (ConfigStore.to.screenWidth.isMobile) {
        return const SettingMobile();
      }
      return const SettingWeb();
    }

    if (ConfigStore.to.screenWidth.isTablet) {
      return const SettingTablet();
    }

    return const SettingMobile();
  }

  @override
  void initState() {
    super.initState();
    Get.put(SettingController());
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<SettingController>();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) => _renderUI(context),
    );
  }
}
