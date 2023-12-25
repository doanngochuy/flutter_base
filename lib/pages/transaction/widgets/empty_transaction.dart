import 'package:EMO/common/styles/styles.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';

Widget emptyTransaction() => EmptyWidget(
      packageImage: PackageImage.Image_3,
      title: 'Chưa thực hiện nhiệm vụ',
      subTitle: 'Thực hiện nhiệm vụ để nhận thưởng nhé',
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: AppColor.primary.withOpacity(0.8),
        fontWeight: FontWeight.w500,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 14,
        color: AppColor.primary.withOpacity(0.5),
      ),
    );
