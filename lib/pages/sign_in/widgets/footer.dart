import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/pages/sign_up/index.dart';
import 'package:flutter/material.dart';

class SignInFooter extends StatelessWidget {
  const SignInFooter({Key? key}) : super(key: key);

  void _handleSignUp(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Text(
            S.current.Neu_ban_chua_co_tai_khoan,
            style: TextStyles.title1.copyWith(
              color: AppColor.black800,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        CustomButton.fullColor(
          text: S.current.Dang_ky,
          padding: EdgeInsets.zero,
          background: Colors.transparent,
          textStyle:
              TextStyles.title1.copyWith(color: AppColor.blueLight, fontWeight: FontWeight.w500),
          onPressed: () => _handleSignUp(context),
        ),
      ],
    );
  }
}
