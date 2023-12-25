import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get to => Get.find();

  SignUpController();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final userController = TextEditingController();
  final passController = TextEditingController();
  final fbKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<bool> handleSignUp() async =>
      await Loading.openAndDismissLoading<bool>(
        () async {
          //Get serial device
          await UserStore.to.onSignUp(
            fullName: fullNameController.text,
            email: emailController.text,
            userName: userController.text,
            passwords: passController.text,
          );
          CustomSnackBar.success(
            title: S.current.Thanh_cong,
            message: S.current.Dang_ky_thanh_cong,
          );
          return true;
        },
      ) ??
      false;
}
