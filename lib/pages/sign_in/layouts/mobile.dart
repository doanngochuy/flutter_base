import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/pages/sign_in/widgets/widgets.dart';

class SignInMobile extends StatelessWidget {
  const SignInMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool compactVerticalSpace = context.height < 540;
    return Padding(
      padding: EdgeInsets.all(Insets.lg),
      child: Column(
        children: <Widget>[
          VSpace.lg,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  SignInHeader(),
                  VSpace.lg,
                  const SignInForm(),
                  VSpace.lg,
                  SignInButtonsAction(),
                ],
              ),
            ),
          ),
          compactVerticalSpace ? Container() : SignInFooter(),
        ],
      ),
    );
  }
}
