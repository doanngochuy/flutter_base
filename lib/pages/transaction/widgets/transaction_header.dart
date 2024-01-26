import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/utils.dart';

class TransactionHeaderWidget extends StatelessWidget {
  const TransactionHeaderWidget({
    Key? key,
    required this.countItem,
    required this.totalMoney,
    required this.totalWithdraw,
  }) : super(key: key);

  final int countItem;
  final int totalMoney;
  final int totalWithdraw;
  int get totalRemain => totalMoney - totalWithdraw;

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
            decoration: const BoxDecoration(
              color: AppColor.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(9),
            child: Icon(
              icon,
              color: colorIcon,
              size: 22,
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
      width: context.width,
      padding: EdgeInsets.all(Insets.sm),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(1, 3), // changes position of shadow
          ),
        ],
      ),
      child: Wrap(
        runSpacing: Insets.med,
        children: <Widget>[
          _infoItem(
            width: _widthInfoItem(context),
            title: "Nhiệm vụ đã làm",
            info: countItem.toCurrencyStr,
            icon: FontAwesomeIcons.briefcase,
            colorIcon: AppColor.blueLight,
          ),
          _infoItem(
            width: _widthInfoItem(context),
            title: "Tổng tiền",
            info: "${totalMoney.toCurrencyStr}đ",
            icon: FontAwesomeIcons.sackDollar,
            colorIcon: AppColor.yellowColor,
          ),
          _infoItem(
            width: _widthInfoItem(context),
            title: "Đã rút",
            info: '${totalWithdraw.toCurrencyStr}đ',
            icon: FontAwesomeIcons.moneyBill,
            colorIcon: Colors.lightGreen,
          ),
          _infoItem(
            width: _widthInfoItem(context),
            title: "Số dư",
            info: "${totalRemain.toCurrencyStr}đ",
            icon: FontAwesomeIcons.wallet,
            colorIcon: AppColor.orange,
          ),
        ],
      ),
    );
  }
}
