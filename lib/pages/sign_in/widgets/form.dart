import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:EMO/pages/sign_in/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final signInController = SignInController.to;
  final FocusNode shopFocusNode = FocusNode();
  final FocusNode userFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  /// constants only in widgets
  static const Color mainInputColor = AppColor.blueLight;
  static final EdgeInsets paddingTextEditor = EdgeInsets.fromLTRB(
    Insets.lg / 2,
    Insets.lg,
    Insets.lg / 2,
    Insets.lg,
  );
  static final TextStyle floatingLabelStyle = TextStyles.title1.copyWith(
    color: mainInputColor,
    height: 1,
  );
  static final TextStyle textStyle = TextStyles.title1.copyWith(
    color: AppColor.black800,
  );

  bool isShowPassword = true;

  Widget renderIcon(IconData icon) {
    return Icon(
      icon,
      color: AppColor.black800,
      size: IconSizes.sm,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: signInController.fbKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          CustomInput.outline(
            backgroundColor: AppColor.grey100,
            controller: signInController.userController,
            padding: paddingTextEditor,
            prefixIcon: renderIcon(CustomIcons.user),
            textAlign: TextAlign.start,
            labelText: S.current.Tai_khoan,
            labelStyle: textStyle.copyWith(color: AppColor.grey600),
            floatingLabelStyle: floatingLabelStyle,
            textStyle: textStyle,
            colorBorderFocus: mainInputColor,
            action: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: S.current.Vui_long_khong_de_trong),
            ]),
            focusNode: userFocusNode,
            onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(passwordFocusNode),
          ),
          VSpace.lg,
          CustomInput.outline(
            backgroundColor: AppColor.grey100,
            controller: signInController.passController,
            padding: paddingTextEditor.copyWith(right: 0),
            prefixIcon: renderIcon(CustomIcons.lock),
            suffixIcon: IconButton(
              onPressed: () => setState(() => isShowPassword = !isShowPassword),
              icon: renderIcon(isShowPassword ? CustomIcons.eye_slash : CustomIcons.eye),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              padding: EdgeInsets.only(right: Insets.sm),
            ),
            textAlign: TextAlign.start,
            labelText: S.current.Mat_khau,
            labelStyle: textStyle.copyWith(color: AppColor.grey600),
            floatingLabelStyle: floatingLabelStyle,
            textStyle: textStyle,
            colorBorderFocus: mainInputColor,
            type: TextInputType.visiblePassword,
            isShow: isShowPassword,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: S.current.Vui_long_khong_de_trong),
            ]),
            focusNode: passwordFocusNode,
          ),
          VSpace.lg,
          // CustomButton.fullColor(
          //   text: S.current.Quen_mat_khau,
          //   background: Colors.transparent,
          //   textColor: AppColor.blueLight,
          //   padding: EdgeInsets.zero,
          //   height: heightBtnForgetPassword,
          //   onPressed: signInController.handleForgotPassword,
          // ),
        ],
      ),
    );
  }
}
