import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/styles/color.dart';
import 'package:flutter_base/common/styles/main_styles.dart';
import 'package:flutter_base/common/theme/buttons/custom_button.dart';
import 'package:flutter_base/common/theme/spaces/spaces.dart';
import 'package:flutter_base/common/utils/extensions/extensions.dart';

import 'controller.dart';

class TakePhoto extends StatefulWidget {
  final ReturnImageUrl callBack;

  const TakePhoto({super.key, required this.callBack});

  @override
  State<StatefulWidget> createState() => _TakePhoto();
}

class _TakePhoto extends State<TakePhoto> {
  final TakePhotoController controller = Get.put(TakePhotoController());

  void getImage({bool isTakePhoto = false}) {
    context.popNavigator();
    controller.getImage(isTakePhoto: isTakePhoto).then((value) => widget.callBack.call(value));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.scaleSize,
      width: context.isTablet ? context.width / 2 : context.width,
      child: Column(
        children: [
          CustomButton.customOutline(
              borderColor: AppColor.blueLight,
              background: AppColor.blueLight,
              radius: Corners.xl,
              width: context.width,
              padding: EdgeInsets.symmetric(vertical: 15.scaleSize),
              onPressed: () => getImage(isTakePhoto: true),
              child: Text(
                S.current.Chup_anh,
                style: TextStyles.title1.copyWith(color: AppColor.white),
              )),
          VSpace.sm,
          CustomButton.customOutline(
              borderColor: AppColor.blueLight,
              background: AppColor.blueLight,
              radius: Corners.xl,
              width: context.width,
              padding: EdgeInsets.symmetric(vertical: 15.scaleSize),
              onPressed: getImage,
              child: Text(S.current.Chon_anh_tu_thu_vien,
                  style: TextStyles.title1.copyWith(color: AppColor.white)))
        ],
      ),
    );
  }
}
