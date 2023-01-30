import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/models/models.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/common/values/values.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInController extends GetxController {
  static SignInController get to => Get.find();

  SignInController();

  final TextEditingController userController =
      TextEditingController(text: 'admin');
  final TextEditingController passController =
      TextEditingController(text: '123456');
  final fbKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  // TODO forgot password
  Future<void> handleForgotPassword() async {
    CustomToast.info(msg: 'Forgot pass');
  }

  Future<bool> handleSignIn() async =>
      await Loading.openAndDismissLoading<bool>(
        () async {
          try {
            await UserStore.to.onLogin(
              userName: userController.text,
              passwords: passController.text,
            );
            CustomSnackBar.success(
              title: S.current.Thanh_cong,
              message: S.current.Dang_nhap_thanh_cong,
            );
            return true;
          } catch (e) {
            CustomSnackBar.error(
              title: S.current.That_bai,
              message: e.toString(),
            );
            return false;
          }
        },
      ) ??
      false;

  // TODO sign up
  Future<void> handleSignUp() async {
    CustomToast.info(msg: 'Sign up');
  }

  void handleCallSupport() => launchUrl(
        Uri(
          scheme: 'tel',
          path: $phoneSupport,
        ),
      );
}