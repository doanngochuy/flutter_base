import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/values/values.dart';
import 'package:EMO/pages/sign_in/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInMobile extends StatelessWidget {
  const SignInMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool compactVerticalSpace = context.height < 540;
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: context.height / 18,
            ),
            Image.asset(
              AppImages.$appIcon,
              width: 100 * ConfigStore.to.scale,
            ),
            VSpace.sm,
            Text(
              'Welcome to EMO',
              style: TextStyles.title1.copyWith(
                color: AppColor.primaryDark,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Insets.med),
              child: Card(
                elevation: 5,
                color: AppColor.white,
                surfaceTintColor: AppColor.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Insets.lg),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      VSpace.lg,
                      const SignInForm(),
                      VSpace.lg,
                      SignInButtonsAction(),
                      VSpace.lg,
                    ],
                  ),
                ),
              ),
            ),
            VSpace.lg,
            compactVerticalSpace ? Container() : const SignInFooter(),
          ],
        ),
      ),
    );
  }
}
