import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/router/router.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:EMO/common/widgets/components/components.dart';
import 'package:EMO/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'account_setting/account_setting.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  User get user => UserStore.to.user;

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

  void _handleDeleteUser() {
    CustomDialog.delete(
      context,
      title: "Bạn chắc chắn muốn xóa tài khoản này?",
      onDelete: () => UserStore.to.blockUser(),
    );
  }

  Widget backGround() => SizedBox(
        height: context.height,
        width: context.width,
        child: Column(
          children: [
            Container(
              height: context.height / 3,
              width: context.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: <Color>[AppColor.primary, AppColor.primaryLight]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constrains) => Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              backGround(),
              Positioned.fill(
                top: 30,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 3, bottom: 3, right: 10, left: 10),
                        margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 0),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            )),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Chuyển tài khoản',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primary,
                                  fontSize: 15),
                            ),
                            HSpace.xs,
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: CircleAvatar(
                                  radius: 36.scaleSize,
                                  backgroundColor: AppColor.orange,
                                  child: Text(
                                    user.fullName.isNotEmpty ? user.fullName[0].toUpperCase() : "A",
                                    style: TextStyle(
                                        fontSize: 36.scaleSize,
                                        color: AppColor.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Xin chào',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          user.fullName,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ViewRemoveAccBTN(
                                          text: "Xóa tài khoản",
                                          onPressed: _handleDeleteUser,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.headset_mic_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      const Text(
                                        "Trợ giúp",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(1, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            optionProfile(
                                name: 'Thiết lập tài khoản',
                                icon: Icons.person,
                                iconColor: Colors.deepOrange,
                                onTap: () => context.pushNavigator(
                                  const AccountSetting(),
                                  transitionType: ContextPushTransitionType.rightToLeft,
                                ),
                            ),
                            optionProfile(
                              name: 'Cài đặt thanh toán',
                              icon: Icons.add_card_outlined,
                              onTap: () => context.pushNavigator(
                                const PaymentSetupPage(),
                                transitionType: ContextPushTransitionType.rightToLeft,
                              ),
                            ),
                            optionProfile(
                              name: 'Đăng xuất',
                              icon: Icons.logout,
                              iconColor: Colors.blue,
                              onTap: () => Loading.openAndDismissLoading(
                                () => UserStore.to
                                    .onLogout()
                                    .whenComplete(() => context.go(ScreenRouter.signUp.path)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      VSpace.sm,
                      const VersionWidget(),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
