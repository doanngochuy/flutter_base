import 'package:flutter/material.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/router/router.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/pages/sign_in/controller.dart';
import 'package:go_router/go_router.dart';

class SignInButtonsAction extends StatelessWidget {
  SignInButtonsAction({Key? key}) : super(key: key);

  final SignInController _signInController = SignInController.to;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        CustomButton.fullColor(
          text: S.current.Dang_nhap.toUpperCase(),
          width: size.width,
          padding: EdgeInsets.all(Insets.lg),
          background: AppColor.successColor,
          boxShadow: Shadows.universal,
          onPressed: () {
            if (!_signInController.fbKey.currentState!.saveAndValidate()) {
              return;
            }
            _signInController.handleSignIn().then((value) {
              if (value) {
                context.goNamed(ScreenRouter.jobDone.name);
              }
            });
          },
        ),
      ],
    );
  }
}
