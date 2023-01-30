import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/store/config_store.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/utils/utils.dart';
import 'package:flutter_base/pages/setting/widgets/payment_setup_detail.dart';

class PaymentSetupPage extends StatelessWidget {
  const PaymentSetupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.black800),
          onPressed: () => context.popNavigator(),
        ),
        title: Text(S.current.Thiet_lap_thanh_toan, style: TextStyles.title1),
        centerTitle: false,
      ),
      body: LayoutBuilder(
        builder: (context, constrains) => Container(
          height: constrains.maxHeight,
          color: AppColor.grey300WithOpacity500,
          padding: EdgeInsets.all(Insets.med),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(child: PaymentSetupDetailWidget()),
              if (GetPlatform.isWeb && ConfigStore.to.screenWidth.isMobile)
                Expanded(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          S.current.Huong_dan_thiet_lap_thanh_toan_o_day.toUpperCase(),
                          style: TextStyles.title1,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
