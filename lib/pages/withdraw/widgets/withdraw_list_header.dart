import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class JobListHeaderWidget extends StatelessWidget {
  const JobListHeaderWidget({
    Key? key,
    required this.countItem,
    required this.totalMoney,
  }) : super(key: key);

  final int countItem;
  final int totalMoney;

  static double _widthInfoItem(BuildContext context) {
    final double withItem = context.width - 3 * Insets.sm;
    return withItem * 0.5;
  }

  Widget _infoItem({
    required double width,
    required String title,
    required String info,
    required Color colorIcon,
    required IconData icon,
  }) {
    return SizedBox(
      width: width,
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(Insets.sm),
            child: Icon(
              icon,
              color: colorIcon,
              size: IconSizes.med,
            ),
          ),
          HSpace(Insets.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyles.title1.copyWith(
                    color: AppColor.grey300,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                ),
                VSpace(Insets.sm),
                Text(
                  info,
                  style: TextStyles.title1.copyWith(
                    color: AppColor.white,
                    height: 1,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Insets.sm),
      decoration: const BoxDecoration(
        color: AppColor.successColor,
        borderRadius: Corners.medBorder,
      ),
      child: Wrap(
        runSpacing: Insets.med,
        children: <Widget>[
          _infoItem(
            width: _widthInfoItem(context),
            title: "Nhiệm vụ đã làm",
            info: countItem.toCurrencyStr,
            icon: Icons.inventory_outlined,
            colorIcon: AppColor.successColor,
          ),
          _infoItem(
            width: _widthInfoItem(context),
            title: "Tổng tiền",
            info: "${totalMoney.toCurrencyStr}đ",
            icon: Icons.attach_money,
            colorIcon: AppColor.warnColor,
          ),
          _infoItem(
            width: _widthInfoItem(context),
            title: "Đã rút",
            info: '500đ',
            icon: Icons.star,
            colorIcon: AppColor.successColor,
          ),
        ],
      ),
    );
  }
}
