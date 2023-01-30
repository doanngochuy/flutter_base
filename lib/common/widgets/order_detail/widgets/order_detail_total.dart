import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';

class OrderDetailTotal {
  final String title;
  final String value;
  final bool isBold;
  final Color? color;

  OrderDetailTotal({
    required this.title,
    required this.value,
    this.isBold = false,
    this.color,
  });
}

class OrderDetailTotalWidget extends StatelessWidget {
  const OrderDetailTotalWidget({
    Key? key,
    required this.rows,
  }) : super(key: key);

  final List<OrderDetailTotal> rows;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
              Insets.med,
              0,
              Insets.med,
              Insets.med,
            ),
            child: Container(
              decoration: const BoxDecoration(
                border: BorderDirectional(
                  top: BorderSide(
                    color: AppColor.orange,
                    width: Strokes.thin,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: Insets.med),
              child: Column(
                children: rows
                    .map<Widget>(
                      (e) => _invoiceDetailItem(
                        left: e.title,
                        right: e.value,
                        weightRight: e.isBold ? FontWeight.bold : FontWeight.w500,
                        colorRight: e.color ?? AppColor.black800,
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _invoiceDetailItem({
    required String left,
    required String right,
    Color colorRight = AppColor.black800,
    FontWeight weightRight = FontWeight.bold,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: Insets.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            left,
            style: TextStyles.title1.copyWith(
              color: AppColor.grey600,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            right,
            style: TextStyles.title1.copyWith(
              color: colorRight,
              fontWeight: weightRight,
            ),
          ),
        ],
      ),
    );
  }
}
