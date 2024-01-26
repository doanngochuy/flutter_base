import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMO/common/entities/setting_model.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';

class StoreInfoDialog extends StatefulWidget {
  const StoreInfoDialog({Key? key}) : super(key: key);

  @override
  State<StoreInfoDialog> createState() => _StoreInfoDialogState();
}

class _StoreInfoDialogState extends State<StoreInfoDialog> {
  final nameController = TextEditingController(),
      addressController = TextEditingController(),
      phoneController = TextEditingController(),
      footerController = TextEditingController(),
      bannerControllers = List.generate(2, (index) => TextEditingController()),
      slideshowControllers = List.generate(3, (index) => TextEditingController());

  @override
  void initState() {
    super.initState();
    initFormData();
  }

  void initFormData() {}

  void handleSubmit() {
    final data = StoreInfoData(
      storeName: nameController.text,
      storeAddress: addressController.text,
      storePhone: phoneController.text,
      footer: footerController.text,
      banners: bannerControllers.map((controller) => controller.text).toList(),
      slideshows: slideshowControllers.map((controller) => controller.text).toList(),
    );

    Navigator.pop(context, data);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: Corners.lgBorder),
      title:
          Text(S.current.Thong_tin_cua_hang, style: TextStyles.title1, textAlign: TextAlign.center),
      content: IntrinsicHeight(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    formElement(
                      name: S.current.Ten,
                      controller: nameController,
                    ),
                    formElement(
                      name: S.current.Dia_chi,
                      controller: addressController,
                    ),
                    formElement(
                      name: S.current.So_dien_thoai,
                      controller: phoneController,
                    ),
                    // Todo: add banner and slideshow
                    formElement(
                      name: S.current.Chan_trang,
                      controller: footerController,
                    ),
                    formElement(
                      name: S.current.Banner_ads_1,
                      controller: bannerControllers[0],
                    ),
                    formElement(
                      name: S.current.Slideshow_1,
                      controller: slideshowControllers[0],
                    ),
                  ],
                ),
              ),
            ),
            CustomButton.fullColor(
              width: double.infinity,
              onPressed: handleSubmit,
              text: S.current.Ap_dung,
            ),
          ],
        ),
      ),
    );
  }

  Widget formElement({
    required String name,
    TextEditingController? controller,
    bool enabled = true,
    bool isTransparent = false,
    String? hintText,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name.tr, style: TextStyles.title2),
          CustomInput.outline(
            controller: controller,
            height: 30,
            enabled: enabled,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            textStyle: TextStyles.title2.copyWith(color: AppColor.blueLight),
            hintTextStyle: TextStyles.title2.copyWith(color: AppColor.grey300),
            borderRadius: Corners.lg,
            backgroundColor: isTransparent ? Colors.transparent : null,
            colorBorder: isTransparent ? Colors.transparent : AppColor.grey300,
          ),
          VSpace(Insets.sm),
        ],
      );
}
