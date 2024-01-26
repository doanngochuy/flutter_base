import 'dart:math';

import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showBankDialog(
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
      title: "Chọn ngân hàng",
      content: SizedBox(
        width: min(650.scaleSize, context.width),
        height: 415.scaleSize,
        child: BanksDialog(
          transactionMethods: paymentMethods,
          initTransactionMethod: initPaymentMethod,
          onSelect: onSelect,
        ),
      ),
    );

class BanksDialog extends StatefulWidget {
  const BanksDialog({
    Key? key,
    required this.transactionMethods,
    required this.initTransactionMethod,
    required this.onSelect,
  }) : super(key: key);

  final List<String> transactionMethods;
  final String initTransactionMethod;
  final Function(String) onSelect;

  @override
  State<BanksDialog> createState() => _BanksDialogState();
}

class _BanksDialogState extends State<BanksDialog> {
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
