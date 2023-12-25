import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/models/models.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.isSelected,
    required this.item,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final Transaction item;
  final int index;
  final ValueChanged<Transaction> onTap;

  JobState get _jobState => item.money == item.job.money ? JobState.done : JobState.cancel;

  @override
  Widget build(BuildContext context) {
    return CustomButton.customFullColor(
      onPressed: () => onTap(item),
      clickColor: AppColor.grey300,
      background: _backgroundColorBtn(),
      padding: EdgeInsets.zero,
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 0,
              right: Insets.sm,
              bottom: Insets.sm,
              top: Insets.sm,
            ),
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
                          Expanded(
                            child: Text(
                              item.job.baseUrl,
                              style: TextStyles.title1.copyWith(
                                color: AppColor.black800,
                              ),
                            ),
                          ),
                          _renderStatus(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.access_time_filled,
                            color: AppColor.grey600,
                            size: 18,
                          ),
                          const SizedBox(width: 1),
                          Expanded(
                            child: Text(
                              item.createdAt.shortDateAndTimeStr,
                              style: TextStyles.body1.copyWith(
                                color: AppColor.grey600,
                              ),
                            ),
                          ),
                          _renderTotalPayment(
                            item.money,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: Insets.xs,
            color: AppColor.grey300,
            indent: Insets.med,
            endIndent: Insets.med,
          ),
          VSpace.sm,
        ],
      ),
    );
  }

  Widget _renderStatus() {
    late Color color;
    switch (_jobState) {
      case JobState.done:
        color = AppColor.primary;
        break;
      case JobState.cancel:
        color = AppColor.errorColor;
        break;
      case JobState.pending:
        color = AppColor.yellowColor;
        break;
    }
    return Text(
      _jobState.getNameStatus,
      style: TextStyles.title1.copyWith(color: color),
    );
  }

  Widget _renderTotalPayment(int total) => _jobState == JobState.done
      ? Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.monetization_on,
              color: AppColor.yellowColor,
              size: 16,
            ),
            const SizedBox(width: 1),
            Text(
              "${total.toCurrencyStr}đ",
              style: TextStyles.title1.copyWith(color: AppColor.yellowColor),
            ),
          ],
        )
      : const SizedBox();

  Widget _renderIconData(int index) => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _jobState == JobState.done ? AppColor.primary : AppColor.grey600,
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
