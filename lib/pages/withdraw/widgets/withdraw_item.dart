import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/models/models.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:flutter/material.dart';

class WithdrawItem extends StatelessWidget {
  const WithdrawItem({
    Key? key,
    required this.isSelected,
    required this.withdraw,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final Withdraw withdraw;
  final int index;
  final ValueChanged<Withdraw> onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Insets.med,
      ).copyWith(
        bottom: Insets.med,
      ),
      child: CustomButton.customFullColor(
        onPressed: () => onTap(withdraw),
        clickColor: AppColor.grey300,
        background: _backgroundColorBtn(),
        padding: EdgeInsets.only(
          left: 0,
          right: Insets.sm,
          bottom: Insets.sm,
          top: Insets.sm,
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 60.scaleSize,
              child: _renderIconData(index),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        withdraw.accountName,
                        style: TextStyles.title1.copyWith(
                          color: AppColor.black800,
                        ),
                      ),
                      _renderStatus(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        DateTime.now().fullDateAndTimeStr,
                        style: TextStyles.body1.copyWith(
                          color: AppColor.black800,
                        ),
                      ),
                      _renderTotalPayment(
                        withdraw.money,
                        JobState.done,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _renderStatus({WithdrawStatus? status}) {
    late Color color;
    switch (status) {
      case WithdrawStatus.transferred:
        color = AppColor.successColor;
        break;
      case WithdrawStatus.requested:
        color = AppColor.orange;
        break;
      case null:
        color = AppColor.errorColor;
        break;
    }
    return Text(
      status?.getTitle() ?? '',
      style: TextStyles.title1.copyWith(color: color),
    );
  }

  Widget _renderTotalPayment(int total, JobState status) {
    Color color = AppColor.warnColor;
    if (status == JobStatus.done) {
      color = AppColor.blueLight;
    } else if (status == JobState.cancel) {
      color = AppColor.errorColor;
    }
    return Text(
      "${truncateNumberToString(total)}đ",
      style: TextStyles.title1.copyWith(color: color),
    );
  }

  Widget _renderIconData(int index) => Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.successColor,
          // borderRadius: Corners.lgBorder,
        ),
        alignment: Alignment.center,
        child: Text(
          "${index + 1}",
          style: TextStyles.title1.copyWith(color: AppColor.white),
        ),
      );

  Color _backgroundColorBtn() {
    Color color = AppColor.white;
    if (!isSelected) return color;
    if (ConfigStore.to.screenWidth.isTablet) return AppColor.grey300;
    return color;
  }
}
