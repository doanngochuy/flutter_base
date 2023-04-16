import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../index.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _controller = SignUpController.to;
  final fullNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final userFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final rePasswordFocusNode = FocusNode();

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

  /// =========================

  bool isShowPassword = true;

  Widget renderIcon(IconData icon, {double? size}) {
    return Icon(
      icon,
      color: AppColor.black800,
      size: size ?? IconSizes.med,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _controller.fbKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          CustomInput.outline(
            controller: _controller.fullNameController,
            padding: paddingTextEditor,
            prefixIcon: renderIcon(Icons.drive_file_rename_outline),
            textAlign: TextAlign.start,
            labelText: "Tên đầy đủ",
            labelStyle: textStyle.copyWith(color: AppColor.grey600),
            floatingLabelStyle: floatingLabelStyle,
            textStyle: textStyle,
            colorBorderFocus: mainInputColor,
            action: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: S.current.Vui_long_khong_de_trong),
              FormBuilderValidators.match(r'^[a-zA-ZÀ-Ỹà-ỹ ]+$', errorText: "Tên không hợp lệ"),
            ]),
            focusNode: fullNameFocusNode,
            onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(fullNameFocusNode),
          ),
          VSpace.lg,
          CustomInput.outline(
            controller: _controller.emailController,
            padding: paddingTextEditor,
            prefixIcon: renderIcon(Icons.email_outlined),
            textAlign: TextAlign.start,
            labelText: "Email",
            labelStyle: textStyle.copyWith(color: AppColor.grey600),
            floatingLabelStyle: floatingLabelStyle,
            textStyle: textStyle,
            colorBorderFocus: mainInputColor,
            action: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: S.current.Vui_long_khong_de_trong),
              FormBuilderValidators.email(errorText: S.current.Email_khong_hop_le),
            ]),
            focusNode: emailFocusNode,
            isEmail: true,
            type: TextInputType.emailAddress,
            onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(emailFocusNode),
          ),
          VSpace.lg,
          CustomInput.outline(
            controller: _controller.userController,
            padding: paddingTextEditor,
            prefixIcon: renderIcon(Icons.person),
            textAlign: TextAlign.start,
            labelText: S.current.Tai_khoan,
            labelStyle: textStyle.copyWith(color: AppColor.grey600),
            floatingLabelStyle: floatingLabelStyle,
            textStyle: textStyle,
            colorBorderFocus: mainInputColor,
            action: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: S.current.Vui_long_khong_de_trong),
              FormBuilderValidators.match(
                r'^[a-zA-Z0-9]+$',
                errorText: 'Không chứa khoảng trắng và ký tự đặc biệt',
              ),
            ]),
            focusNode: userFocusNode,
            onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(passwordFocusNode),
          ),
          VSpace.lg,
          CustomInput.outline(
            controller: _controller.passController,
            padding: paddingTextEditor.copyWith(right: 0),
            prefixIcon: renderIcon(Icons.lock),
            suffixIcon: IconButton(
              onPressed: () => setState(() => isShowPassword = !isShowPassword),
              icon: renderIcon(isShowPassword ? CustomIcons.eye_slash : CustomIcons.eye,
                  size: IconSizes.sm),
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
              FormBuilderValidators.match(
                r'^\S+$',
                errorText: 'Không chứa khoảng trắng',
              ),
              FormBuilderValidators.minLength(6, errorText: 'Mật khẩu phải có ít nhất 6 ký tự'),
              FormBuilderValidators.maxLength(10, errorText: 'Mật khẩu không được quá 10 ký tự'),
            ]),
            focusNode: passwordFocusNode,
          ),
          VSpace.lg,
          CustomInput.outline(
            controller: _controller.rePassController,
            padding: paddingTextEditor.copyWith(right: 0),
            prefixIcon: renderIcon(Icons.lock_reset_rounded, size: IconSizes.lg),
            suffixIcon: IconButton(
              onPressed: () => setState(() => isShowPassword = !isShowPassword),
              icon: renderIcon(isShowPassword ? CustomIcons.eye_slash : CustomIcons.eye,
                  size: IconSizes.sm),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              padding: EdgeInsets.only(right: Insets.sm),
            ),
            textAlign: TextAlign.start,
            labelText: "Nhập lại mật khẩu",
            labelStyle: textStyle.copyWith(color: AppColor.grey600),
            floatingLabelStyle: floatingLabelStyle,
            textStyle: textStyle,
            colorBorderFocus: mainInputColor,
            type: TextInputType.visiblePassword,
            isShow: isShowPassword,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: S.current.Vui_long_khong_de_trong),
              FormBuilderValidators.equal(_controller.passController.text,
                  errorText: 'Mật khẩu không khớp')
            ]),
            focusNode: rePasswordFocusNode,
          ),
          VSpace.lg,
        ],
      ),
    );
  }
}
