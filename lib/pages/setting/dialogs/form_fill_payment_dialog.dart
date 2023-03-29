import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMO/common/entities/setting_model.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';

class FormFillPaymentDialog extends StatefulWidget {
  final MerchantAttributeData merchantAttributeData;

  const FormFillPaymentDialog({
    Key? key,
    required this.merchantAttributeData,
  }) : super(key: key);

  @override
  State<FormFillPaymentDialog> createState() => _FormFillPaymentDialogState();
}

class _FormFillPaymentDialogState extends State<FormFillPaymentDialog> {
  final _controller = TextEditingController();
  bool _isSubmittable = false;

  void handleSubmit() {
    Navigator.of(context).pop(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: Corners.lgBorder),
      title: Text(
        widget.merchantAttributeData.merchant.tr,
        style: TextStyles.title1.copyWith(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      content: IntrinsicHeight(
        child: Column(
          children: [
            const Icon(Icons.edit_note_outlined,
                color: AppColor.blueLight, size: 60),
            VSpace.lg,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${S.current.Moi_nhap} ${widget.merchantAttributeData.attribute.tr.toLowerCase()}",
                style: TextStyles.body1,
              ),
            ),
            VSpace(Insets.sm),
            CustomInput.outline(
              hintText: widget.merchantAttributeData.value,
              controller: _controller,
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              borderRadius: Corners.lg,
              colorBorder: AppColor.grey300,
              backgroundColor: Colors.white,
              onChanged: (value) => setState(
                  () => _isSubmittable = (value != null && value.isNotEmpty)),
            ),
            VSpace(Insets.sm),
            _isSubmittable
                ? CustomButton.fullColor(
                    width: double.infinity,
                    onPressed: handleSubmit,
                    text: S.current.Ap_dung,
                  )
                : CustomButton.fullColor(
                    width: double.infinity,
                    onPressed: () {},
                    text: S.current.Ap_dung,
                    textColor: AppColor.grey600,
                    background: AppColor.grey300,
                  ),
          ],
        ),
      ),
    );
  }
}
