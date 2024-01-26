import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:EMO/common/values/values.dart';
import 'package:flutter/material.dart';

void showConfigBankDialog(
  BuildContext context, {
  required int initBankKey,
  required Function(int) onSelect,
}) =>
    CustomDialog.show(
      context: context,
      builder: (context) => BankConfigDialog(
        initBankKey: initBankKey,
        onSelect: onSelect,
      ),
    );

class BankConfigDialog extends StatefulWidget {
  const BankConfigDialog({
    super.key,
    required this.initBankKey,
    required this.onSelect,
  });

  final int initBankKey;
  final Function(int) onSelect;

  @override
  State<BankConfigDialog> createState() => _BankConfigDialogState();
}

class _BankConfigDialogState extends State<BankConfigDialog> {
  Map<int, String> banks = <int, String>{};

  void setBanks(Map<int, String> value) => setState(() => banks = value);

  @override
  void initState() {
    super.initState();
    setBanks(AppConstant.mapBankBIN);
  }

  void onTapBankItem(int keyBank) {
    widget.onSelect(keyBank);
    Navigator.pop(context, keyBank);
  }

  void changeTextSearch(String? valueSearch) {
    if (valueSearch == null) return;
    Map<int, String> banks = <int, String>{};
    AppConstant.mapBankBIN.forEach((key, value) {
      if (value.toLatinCharacters
          .toLowerCase()
          .contains(valueSearch.trim().toLatinCharacters.toLowerCase())) {
        banks[key] = value;
      }
    });
    setBanks(banks);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(borderRadius: Corners.xlBorder),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Chọn ngân hàng",
                style: TextStyles.body1.copyWith(
                    color: AppColor.black800, fontWeight: FontWeight.bold, fontSize: 16.scaleSize),
              ),
            ),
          ),
          InkWell(
            onTap: context.popNavigator,
            child: const Icon(Icons.close, color: AppColor.black800),
          ),
        ],
      ),
      titlePadding: EdgeInsets.fromLTRB(Insets.lg, Insets.lg, Insets.lg, 0),
      contentPadding: EdgeInsets.fromLTRB(Insets.lg, Insets.lg, Insets.lg, Insets.xs),
      children: <Widget>[
        CustomInput.outline(
          isDense: true,
          padding: EdgeInsets.all(Insets.med),
          borderRadius: Corners.lg,
          textColor: AppColor.primary,
          backgroundColor: Colors.transparent,
          onChanged: changeTextSearch,
          prefixIcon: const Icon(Icons.search),
        ),
        VSpace.xs,
        Container(
          width: 300.scaleSize,
          constraints: BoxConstraints(maxHeight: 500.scaleSize),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: banks.length,
            itemBuilder: (BuildContext context, int index) {
              final keyBank = banks.keys.elementAt(index);
              return Column(
                children: [
                  InkWell(
                    onTap: () => onTapBankItem(keyBank),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Corners.lg),
                        color: AppColor.grey600WithOpacity200,
                        border: Border.all(
                          color: AppColor.whiteColor,
                          width: 1.5.scaleSize,
                        ),
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(Insets.med),
                        child: Text(
                            style: TextStyles.title2,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            banks[keyBank] ?? "",
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                  VSpace.xs
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
