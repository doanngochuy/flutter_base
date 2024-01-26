import 'dart:async';

import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/router/router.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:EMO/common/values/values.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../common/theme/theme.dart';
import 'index.dart';

class CreateWithdrawPage extends StatefulWidget {
  const CreateWithdrawPage({Key? key}) : super(key: key);

  @override
  State<CreateWithdrawPage> createState() => _CreateWithdrawPageState();
}

class _CreateWithdrawPageState extends State<CreateWithdrawPage> {
  final _controller = Get.put(CreateWithdrawController());

  final _descriptionController = TextEditingController();
  final _accNameController = TextEditingController(
    text: AppConfigureStore.to.getAttribute<String>(AppStorage.prefNameAcc),
  );
  final _accNumberController = TextEditingController(
    text: AppConfigureStore.to.getAttribute<String>(AppStorage.prefNumberAcc),
  );
  final _amountController = TextEditingController();

  late StreamSubscription _subscription;

  String _withdrawMethod =
      AppConfigureStore.to.getAttribute<String>(AppStorage.prefWithdrawMethod) ??
          WithdrawStore.to.withdrawMethods.first;

  int _bankKey = AppConfigureStore.to.getAttribute<int>(AppStorage.prefKeyBank) ??
      AppConstant.mapBankBIN.keys.first;

  @override
  void initState() {
    super.initState();
    _controller.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future _postWithdraw() async {
    await Loading.openAndDismissLoading(
      () async {
        final money = _amountController.text.parseSafeInt;
        final account = _accNameController.text;
        final numberAccount = int.parse(_accNumberController.text);
        final description = _descriptionController.text;

        await _controller.createWithdraw(
          money: money,
          account: account,
          numberAccount: numberAccount,
          withdrawMethod: _withdrawMethod,
          bankKey: _bankKey,
          description: description,
        );

        _showConfirmFinish();
      },
      onError: (e) => _showConfirmError(e is DioException ? (e.message ?? "Unknown") : "Unknown"),
    );
  }

  void _showConfirmFinish() => AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.success,
        showCloseIcon: true,
        title: 'Thành công',
        desc: 'Bạn đã hoàn thành công việc này, trở lại màn hình chính?',
        btnOkOnPress: () => context.goNamed(ScreenRouter.home.name),
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) => context.pop(),
      ).show();

  void _showConfirmError(String msg) => AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'Không thành công',
        desc: 'Có lỗi xảy ra ($msg), trở lại màn hình chính?',
        btnOkOnPress: context.pop,
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();

  AppBar _appBar() => AppBar(
        title: const Text("Yêu cầu rút tiền", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: context.pop,
        ),
        centerTitle: true,
      );

  Widget _paddingLabel(Widget child) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Insets.xs,
        top: Insets.sm,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(Insets.lg).copyWith(top: Insets.sm),
              decoration: const BoxDecoration(
                color: AppColor.white,
                borderRadius: Corners.medBorder,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  VSpace.med,
                  _paddingLabel(
                    Text(
                      "Phương thức thanh toán",
                      style: TextStyles.title2.copyWith(
                        color: AppColor.black800,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        CustomButton.outline(
                          onPressed: () => showWithdrawMethodDialog(
                            context,
                            onSelect: (value) => setState(() => _withdrawMethod = value),
                            paymentMethods: WithdrawStore.to.withdrawMethods,
                            initPaymentMethod: _withdrawMethod,
                          ),
                          width: double.infinity,
                          background: AppColor.white,
                          padding: EdgeInsets.all(14.scaleSize),
                          text: _withdrawMethod,
                          clickColor: AppColor.grey300,
                          textAlign: TextAlign.start,
                        ),
                        Positioned(
                          right: Insets.med,
                          child: Icon(
                            CustomIcons.chevron_down,
                            size: IconSizes.sm,
                            color: AppColor.black800,
                          ),
                        )
                      ],
                    ),
                  ),
                  VSpace.xs,
                  if (_withdrawMethod == "Ngân hàng")
                    _paddingLabel(
                      Text(
                        "Tên ngân hàng",
                        style: TextStyles.title2.copyWith(
                          color: AppColor.black800,
                        ),
                      ),
                    ),
                  if (_withdrawMethod == "Ngân hàng")
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          CustomButton.outline(
                            onPressed: () => showConfigBankDialog(
                              context,
                              initBankKey: _bankKey,
                              onSelect: (value) => setState(() => _bankKey = value),
                            ),
                            height: 48.scaleSize,
                            width: double.infinity,
                            background: AppColor.white,
                            padding: EdgeInsets.all(14.scaleSize),
                            text: AppConstant.mapBankBIN[_bankKey] ?? "Chọn ngân hàng",
                            clickColor: AppColor.grey300,
                            textAlign: TextAlign.start,
                          ),
                          Positioned(
                            right: Insets.med,
                            child: Icon(
                              CustomIcons.chevron_down,
                              size: IconSizes.sm,
                              color: AppColor.black800,
                            ),
                          )
                        ],
                      ),
                    ),
                  VSpace.xs,
                  _paddingLabel(
                    Text(
                      "Tên tài khoản",
                      style: TextStyles.title2.copyWith(
                        color: AppColor.black800,
                      ),
                    ),
                  ),
                  CustomInput.outline(
                    backgroundColor: AppColor.white,
                    padding: EdgeInsets.symmetric(
                      vertical: Insets.med,
                      horizontal: Insets.med,
                    ),
                    controller: _accNameController,
                    autoValidateMode: AutovalidateMode.always,
                    type: TextInputType.name,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(
                          errorText: S.current.Vui_long_khong_de_trong,
                        ),
                      ],
                    ),
                  ),
                  VSpace.xs,
                  _paddingLabel(
                    Text(
                      "Số tài khoản",
                      style: TextStyles.title2.copyWith(
                        color: AppColor.black800,
                      ),
                    ),
                  ),
                  CustomInput.outline(
                    backgroundColor: AppColor.white,
                    padding: EdgeInsets.symmetric(
                      vertical: Insets.med,
                      horizontal: Insets.med,
                    ),
                    controller: _accNumberController,
                    autoValidateMode: AutovalidateMode.always,
                    type: TextInputType.number,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(
                          errorText: S.current.Vui_long_khong_de_trong,
                        ),
                      ],
                    ),
                  ),
                  _paddingLabel(
                    Text(
                      "Số tiền",
                      style: TextStyles.title2.copyWith(
                        color: AppColor.black800,
                      ),
                    ),
                  ),
                  CustomInput.outline(
                    backgroundColor: AppColor.white,
                    padding: EdgeInsets.symmetric(
                      vertical: Insets.med,
                      horizontal: Insets.med,
                    ),
                    controller: _amountController,
                    autoValidateMode: AutovalidateMode.always,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(
                          errorText: S.current.Vui_long_khong_de_trong,
                        ),
                        FormBuilderValidators.min(
                          0,
                          errorText: S.current.Phai_lon_hon_hoac_bang_0,
                        ),
                      ],
                    ),
                    type: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      AppTextInputFormatter.digitsWithComma,
                      AppTextInputFormatter.textWithCommaAndDot,
                    ],
                    valueTransformer: AppTextInputFormatter.reversedFromCommaAndDotToNumber,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: Insets.lg,
                right: Insets.lg,
                bottom: Insets.lg,
                top: Insets.xs,
              ),
              decoration: const BoxDecoration(
                color: AppColor.white,
                borderRadius: Corners.medBorder,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _paddingLabel(
                    Text(
                      S.current.Ghi_chu,
                      style: TextStyles.title2.copyWith(
                        color: AppColor.black800,
                      ),
                    ),
                  ),
                  CustomInput.outline(
                    backgroundColor: AppColor.white,
                    padding: EdgeInsets.symmetric(
                      vertical: Insets.med,
                      horizontal: Insets.med,
                    ),
                    controller: _descriptionController,
                    maxLines: 3,
                    minLines: 3,
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: Insets.lg, horizontal: Insets.lg),
                child: CustomButton.fullColor(
                  onPressed: _postWithdraw,
                  width: double.infinity,
                  text: S.current.Xac_nhan,
                  background: AppColor.primary,
                )),
          ],
        ),
      ),
    );
  }
}
