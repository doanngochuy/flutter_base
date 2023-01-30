import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/utils/utils.dart';

import 'order_detail_header.dart';

class OrderDetailRowBuilder {
  final String name;
  final double price;
  final double quantity;
  final double total;

  const OrderDetailRowBuilder({
    required this.name,
    required this.price,
    required this.quantity,
    required this.total,
  });
}

class OrderDetailBuilderWidget extends StatelessWidget {
  const OrderDetailBuilderWidget({
    Key? key,
    required this.rows,
  }) : super(key: key);

  final List<OrderDetailRowBuilder> rows;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final row = rows[index];
          final List<OrderDetailHeaderCell> builderItems = [
            OrderDetailHeaderCell(
              flex: 5,
              title: row.name,
              align: TextAlign.left,
            ),
            OrderDetailHeaderCell(
              flex: 4,
              title: truncateNumberToString(row.price),
            ),
            OrderDetailHeaderCell(
              flex: 4,
              title: truncateNumberToString(row.quantity),
            ),
            OrderDetailHeaderCell(
              flex: 4,
              title: truncateNumberToString(row.total),
              align: TextAlign.right,
            ),
          ];
          return Padding(
            padding: EdgeInsets.all(Insets.med),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: builderItems
                  .map<Widget>(
                    (headerCell) => orderDetailHeaderCellWidget(
                      flex: headerCell.flex,
                      title: headerCell.title,
                      align: headerCell.align,
                    ),
                  )
                  .toList(),
            ),
          );
        },
        childCount: rows.length,
      ),
    );
  }
}
