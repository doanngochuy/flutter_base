import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'controller.dart';
import 'widgets/widgets.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  final _controller = Get.put(AccountSettingController());

  @override
  void dispose() {
    super.dispose();
    Get.delete<AccountSettingController>();
  }

  Widget _buttonApply() {
    return Column(
      children: <Widget>[
        CustomButton.fullColor(
          text: "Lưu",
          width: double.infinity,
          padding: EdgeInsets.all(Insets.lg),
          background: AppColor.primaryDark,
          boxShadow: Shadows.universal,
          onPressed: () {
            if (!_controller.fbKey.currentState!.saveAndValidate()) {
              return;
            }
            _controller.updateUser().then((value) {
              if (value) {
                context.pop();
              }
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.grey100,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColor.black800,
          ),
          onPressed: context.pop,
        ),
        title: Text(
          "Thiết lập Tài khoản",
          style: TextStyles.title1.copyWith(
            color: AppColor.black800,
          ),
        )
      ),
      backgroundColor: AppColor.grey100,
      body: LayoutBuilder(
        builder: (context, constrains) {
          return InkWell(
            highlightColor: Colors.transparent,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Insets.lg,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          VSpace.lg,
                          const AccountForm(),
                          VSpace.lg,
                          _buttonApply(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
