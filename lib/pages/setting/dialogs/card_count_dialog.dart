import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/theme/theme.dart';

class CardCountDialog extends StatefulWidget {
  final String? cardCount;

  const CardCountDialog({
    super.key,
    this.cardCount,
  });

  @override
  State<CardCountDialog> createState() => _CardCountDialogState();
}

class _CardCountDialogState extends State<CardCountDialog> {
  final _controller = TextEditingController();
  bool _isSubmittable = false;

  void handleSubmit() => Navigator.pop<String>(context, _controller.text);

  @override
  void initState() {
    super.initState();
    _controller.text = widget.cardCount ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: Corners.lgBorder),
      title: Text(
        S.current.Cai_dat_the_cung,
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
              child: Text(S.current.Nhap_so_luong_the, style: TextStyles.body1),
            ),
            VSpace(Insets.sm),
            CustomInput.outline(
              hintText: "00~99",
              controller: _controller,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              borderRadius: Corners.lg,
              colorBorder: AppColor.grey300,
              type: TextInputType.number,
              autoValidateMode: AutovalidateMode.always,
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.numeric(
                      errorText: S.current.Du_lieu_khong_hop_le),
                  FormBuilderValidators.max(99,
                      errorText: S.current.Vuot_qua_moc_toi_da),
                  FormBuilderValidators.min(0,
                      errorText: S.current.Vuot_qua_moc_toi_thieu),
                ],
              ),
              onChanged: (value) => setState(
                () => _isSubmittable = (value != null && value.isNotEmpty),
              ),
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
