import 'package:flutter/material.dart';
import 'package:EMO/common/entities/setting_model.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';

class VATConfigDialog extends StatefulWidget {
  final VATConfigData? data;

  const VATConfigDialog({
    this.data,
    super.key,
  });

  @override
  State<VATConfigDialog> createState() => _VATConfigDialogState();
}

class _VATConfigDialogState extends State<VATConfigDialog> {
  late VATType _vatType;

  final _vatRateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _vatType = widget.data?.vatType ?? VATType.total;
    _vatRateController.text = "${widget.data?.vatRate ?? 0}";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: Corners.lgBorder),
      title: Text(
        S.current.Thiet_lap_vat,
        style: TextStyles.title1.copyWith(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      content: IntrinsicHeight(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Icon(Icons.sell_outlined,
                  color: AppColor.blueLight, size: 60.scaleSize),
              VSpace.lg,
              Row(
                children: [
                  Text(S.current.Gia_tri, style: TextStyles.body1),
                  HSpace.med,
                  Expanded(
                    child: CustomInput.outline(
                      enabled: _vatType == VATType.total,
                      controller: _vatRateController,
                      isDense: true,
                      padding: EdgeInsets.all(Insets.med),
                      borderRadius: Corners.lg,
                      textColor: AppColor.blueLight,
                      backgroundColor: Colors.transparent,
                      type: TextInputType.number,
                    ),
                  )
                ],
              ),
              VSpace.med,
              Align(
                alignment: Alignment.centerLeft,
                child:
                    Text(S.current.Phuong_thuc_tinh, style: TextStyles.body1),
              ),
              ...vatTypeMap.entries.map(
                (e) => CustomButton.outline(
                  width: double.infinity,
                  onPressed: () => setState(() => _vatType = e.key),
                  text: e.value,
                  borderColor:
                      _vatType == e.key ? AppColor.blueLight : AppColor.grey300,
                  textColor: _vatType == e.key
                      ? AppColor.blueLight
                      : AppColor.black800,
                  background:
                      _vatType == e.key ? AppColor.white : AppColor.grey300,
                ),
              ),
              VSpace.xl,
              CustomButton.fullColor(
                width: double.infinity,
                onPressed: () {
                  final responseData = VATConfigData(
                    vatRate: _vatType == VATType.total
                        ? double.tryParse(_vatRateController.text)
                        : null,
                    vatType: _vatType,
                  );

                  Navigator.pop<VATConfigData>(context, responseData);
                },
                text: S.current.Ap_dung,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
