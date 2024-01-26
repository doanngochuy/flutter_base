import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/extensions/extensions.dart';
import 'package:EMO/pages/sign_in/widgets/widgets.dart';

class SignInWeb extends StatelessWidget {
  const SignInWeb({Key? key}) : super(key: key);

  Widget _leftUI() => SignInHeader();

  Widget _rightUI() => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 320.scaleSize,
              child: Column(
                children: <Widget>[
                  VSpace.sm,
                  const SignInForm(),
                  VSpace.lg,
                  SignInButtonsAction(),
                  VSpace.lg,
                  const SignInFooter(),
                ],
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      padding: EdgeInsets.all(Insets.xl),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: _leftUI()),
          HSpace.lg,
          Expanded(child: _rightUI()),
        ],
      ),
    );
  }
}
