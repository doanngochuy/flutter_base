import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMO/common/entities/setting_model.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';

class CurrencyDialog extends StatefulWidget {
  final CurrencyType? currencyType;

  const CurrencyDialog({
    Key? key,
    this.currencyType,
  }) : super(key: key);

  @override
  State<CurrencyDialog> createState() => _CurrencyDialogState();
}

class _CurrencyDialogState extends State<CurrencyDialog> {
  CurrencyType _currencyType = CurrencyType.vnd;

  void handleSubmit() {
    Navigator.of(context).pop<CurrencyType>(_currencyType);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: Corners.lgBorder),
      title: Text(
        S.current.Don_vi_tien_te,
        style: TextStyles.title1.copyWith(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      content: IntrinsicHeight(
        child: Column(
          children: [
            const Icon(Icons.currency_exchange_outlined,
                color: AppColor.blueLight, size: 60),
            VSpace.lg,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...CurrencyType.values.map(
                  (e) => Container(
                    margin: EdgeInsets.symmetric(horizontal: Insets.sm),
                    child: CustomButton.outline(
                      width: MediaQuery.of(context).size.width * 0.22,
                      onPressed: () {
                        setState(() => _currencyType = e);
                      },
                      text: e.title.tr,
                      background: _currencyType == e
                          ? AppColor.white
                          : AppColor.grey300WithOpacity500,
                      textColor: _currencyType == e
                          ? AppColor.blueLight
                          : AppColor.black800,
                      borderColor: _currencyType == e
                          ? AppColor.blueLight
                          : Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
            VSpace(Insets.sm),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.sm),
              child: CustomButton.fullColor(
                width: double.infinity,
                onPressed: handleSubmit,
                text: S.current.Ap_dung,
              ),
            )
          ],
        ),
      ),
    );
  }
}
