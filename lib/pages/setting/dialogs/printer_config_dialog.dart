import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:EMO/common/entities/setting_model.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';

class PrinterConfigDialog extends StatefulWidget {
  final String title;
  final PrinterConfigData? data;
  final PrinterType printerType;

  const PrinterConfigDialog({
    Key? key,
    required this.title,
    this.data,
    this.printerType = PrinterType.paper,
  }) : super(key: key);

  @override
  State<PrinterConfigDialog> createState() => _PrinterConfigDialogState();
}

class _PrinterConfigDialogState extends State<PrinterConfigDialog> {
  late PrintMethod _printMethod;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _printMethod = widget.data?.printMethod ?? PrintMethod.sunmi;
  }

  bool get paperWidthEnable => _printMethod != PrintMethod.none;

  bool get ipAddressEnable => _printMethod == PrintMethod.network;

  List<PrintMethod> get printMethods => [
        PrintMethod.none,
        if (widget.printerType == PrinterType.paper) PrintMethod.sunmi,
        if (widget.printerType == PrinterType.paper) PrintMethod.bluetooth,
        PrintMethod.usb,
        PrintMethod.network,
      ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: Corners.lgBorder),
      title: Text(
        widget.title.tr,
        style: TextStyles.title1.copyWith(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      content: IntrinsicHeight(
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(Icons.print, color: AppColor.blueLight, size: 60),
                VSpace.lg,
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: printMethods
                      .map(
                        (e) => CustomButton.outline(
                          width: e == PrintMethod.network
                              ? double.infinity
                              : MediaQuery.of(context).size.width * 0.33,
                          text: printMethodMap[e]!,
                          textColor: e == _printMethod
                              ? AppColor.blueLight
                              : AppColor.black800,
                          borderColor: e == _printMethod
                              ? AppColor.blueLight
                              : AppColor.grey300,
                          onPressed: () => setState(() => _printMethod = e),
                          radius: Corners.lg,
                        ),
                      )
                      .toList(),
                ),
                FormBuilder(
                  initialValue: {
                    "paperWidth": widget.data?.pageWidth ?? "",
                    "ipAddress": widget.data?.ipAddress ?? "",
                  },
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: "Chieu_rong_giay".tr,
                                children: [
                                  TextSpan(
                                    text: "*",
                                    style: TextStyles.body1
                                        .copyWith(color: AppColor.errorColor),
                                  ),
                                ],
                                style: TextStyles.body1.copyWith(
                                  color: paperWidthEnable
                                      ? AppColor.black800
                                      : AppColor.grey300,
                                ),
                              ),
                            ),
                            VSpace.xs,
                            CustomInput.outline(
                              name: "paperWidth",
                              enabled: paperWidthEnable,
                              borderRadius: Corners.lg,
                              type: TextInputType.number,
                              hintText: "58.8",
                              validator: paperWidthEnable
                                  ? FormBuilderValidators.required(
                                      errorText: "Vui_long_khong_de_trong".tr,
                                    )
                                  : null,
                            )
                          ],
                        ),
                      ),
                      HSpace.med,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dia_chi_IP".tr,
                              style: TextStyles.body1.copyWith(
                                color: ipAddressEnable
                                    ? AppColor.black800
                                    : AppColor.grey300,
                              ),
                            ),
                            VSpace.xs,
                            CustomInput.outline(
                              name: "ipAddress",
                              enabled: ipAddressEnable,
                              borderRadius: Corners.lg,
                              type: TextInputType.number,
                              hintText: "10.0.0.0",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                VSpace.lg,
                CustomButton.fullColor(
                  width: double.infinity,
                  onPressed: handleSubmit,
                  text: 'Ap_dung'.tr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleSubmit() {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;

      final responseData = PrinterConfigData(
        pageWidth: paperWidthEnable ? data["paperWidth"] : null,
        ipAddress: ipAddressEnable ? data["ipAddress"] : null,
        printMethod: _printMethod,
      );

      Navigator.pop<PrinterConfigData>(context, responseData);
    }
  }
}
