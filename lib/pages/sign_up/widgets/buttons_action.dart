import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../index.dart';

class SignUpButtonsAction extends StatelessWidget {
  SignUpButtonsAction({Key? key}) : super(key: key);

  final SignUpController _controller = SignUpController.to;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        CustomButton.fullColor(
          text: S.current.Dang_ky.toUpperCase(),
          width: size.width,
          padding: EdgeInsets.all(Insets.lg),
          background: AppColor.successColor,
          boxShadow: Shadows.universal,
          onPressed: () {
            if (!_controller.fbKey.currentState!.saveAndValidate()) {
              return;
            }
            _controller.handleSignUp().then((value) {
              if (value) {
                context.pop();
              }
            });
          },
        ),
      ],
    );
  }
}
