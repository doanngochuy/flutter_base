import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class AccountSettingController extends GetxController {
  static AccountSettingController get to => Get.find();

  AccountSettingController();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final userController = TextEditingController();
  final fbKey = GlobalKey<FormBuilderState>();

  @override
  void onReady() {
    super.onReady();
    final user = UserStore.to.user;
    userController.text = user.fullName;
    fullNameController.text = user.fullName;
    emailController.text = user.email;
  }

  @override
  void dispose() {
    userController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<bool> updateUser() async =>
      await Loading.openAndDismissLoading<bool>(
        () async {
          //Get serial device
          await UserStore.to.updateUser(
            fullName: fullNameController.text,
            email: emailController.text,
            userName: userController.text,
          );
          CustomSnackBar.success(
            title: S.current.Thanh_cong,
            message: "Cập nhật thành công",
          );
          return true;
        },
      ) ??
      false;
}
