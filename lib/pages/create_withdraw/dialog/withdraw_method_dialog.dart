import 'dart:math';

import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showWithdrawMethodDialog(
    BuildContext context, {
      required List<String> paymentMethods,
      required String initPaymentMethod,
      required Function(String) onSelect,
    }) =>
    CustomDialog.simpleDialog(
      context: context,
      titlePadding: EdgeInsets.only(
        top: Insets.med,
        bottom: 0,
      ),
      title: S.current.Phuong_thuc_thanh_toan,
      content: SizedBox(
        width: min(650.scaleSize, context.width),
        height: 415.scaleSize,
        child: WithdrawMethodDialog(
          transactionMethods: paymentMethods,
          initTransactionMethod: initPaymentMethod,
          onSelect: onSelect,
        ),
      ),
    );

class WithdrawMethodDialog extends StatefulWidget {
  const WithdrawMethodDialog({
    Key? key,
    required this.transactionMethods,
    required this.initTransactionMethod,
    required this.onSelect,
  }) : super(key: key);

  final List<String> transactionMethods;
  final String initTransactionMethod;
  final Function(String) onSelect;

  @override
  State<WithdrawMethodDialog> createState() => _WithdrawMethodDialogState();
}

class _WithdrawMethodDialogState extends State<WithdrawMethodDialog> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: Insets.lg),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(vertical: Insets.xs),
        child: CustomButton.outline(
          onPressed: () {
            context.popNavigator();
            widget.onSelect(widget.transactionMethods[index]);
          },
          width: double.infinity,
          text: widget.transactionMethods[index],
          borderColor: widget.initTransactionMethod == widget.transactionMethods[index]
              ? AppColor.blueLight
              : AppColor.grey300,
          textColor: widget.initTransactionMethod == widget.transactionMethods[index]
              ? AppColor.blueLight
              : AppColor.black800,
        ),
      ),
      itemCount: widget.transactionMethods.length,
    );
  }
}