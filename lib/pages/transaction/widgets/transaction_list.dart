import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:EMO/common/values/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import 'empty_transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final TransactionController _controller = TransactionController.to;

  @override
  void initState() {
    super.initState();
    _controller.state.resetRefreshController();
  }

  void _handleTapItem(
    BuildContext context, {
    required Transaction item,
  }) {}

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.state.transactions.isEmpty
          ? emptyTransaction()
          : AppRefresher(
              controller: _controller.state.refreshController,
              onRefresh: _controller.onRefresh,
              onLoading: _controller.onLoading,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: Insets.med),
                key: Key(AppKey.$scrollViewKey),
                itemCount: _controller.state.transactions.length,
                itemBuilder: _renderItem,
              ),
            ),
    );
  }

  Widget _renderItem(BuildContext context, int index) => Obx(
        () {
          if (index >= _controller.state.transactions.length) return const SizedBox.shrink();
          final itemData = _controller.state.transactions[index];
          DateTime? currentDate = itemData.createdAt;
          final Widget itemWidget = TransactionItem(
            isSelected: false,
            item: itemData,
            index: index,
            onTap: (Transaction transaction) => _handleTapItem(context, item: transaction),
          );
          if (index == 0) {
            return _wrapItemWithDivider(
              child: itemWidget,
              currentDate: currentDate,
            );
          }
          DateTime previousItemDate = _controller.state.transactions[index - 1].createdAt;
          if (DateUtils.isSameDay(currentDate, previousItemDate)) {
            return itemWidget;
          }
          return _wrapItemWithDivider(
            child: itemWidget,
            currentDate: currentDate,
          );
        },
      );

  Widget _wrapItemWithDivider({
    required Widget child,
    DateTime? currentDate,
  }) {
    return Column(
      children: <Widget>[
        _dividerInList(currentDate),
        child,
      ],
    );
  }

  Widget _dividerInList(DateTime? currentDate) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: Insets.sm,
        bottom: Insets.sm,
      ),
      child: Text(
        currentDate != null ? '${currentDate.dayOfWeek}, ${currentDate.dateStr}' : '',
        style: TextStyles.title1.copyWith(
          fontSize: 15,
          color: AppColor.grey600,
        ),
      ),
    );
  }
}
