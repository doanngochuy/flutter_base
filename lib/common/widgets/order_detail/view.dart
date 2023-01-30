import 'package:flutter/material.dart';
import 'package:flutter_base/common/config/config.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/models/models.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/common/utils/utils.dart';

import '../widgets.dart';

class OrderDetailWidget extends StatelessWidget {
  const OrderDetailWidget({
    Key? key,
    required this.totalPayment,
    required this.orderCode,
    this.partnerName,
    this.timeCreate,
    this.timePurchase,
    required this.orderStatus,
    required this.orderDetailProducts,
    required this.orderDetailTotals,
    required this.titleButton1,
    required this.titleButton2,
    required this.action1,
    required this.action2,
    this.isOnlyButton1 = false,
  }) : super(key: key);

  final double totalPayment;
  final String orderCode;
  final String? partnerName;
  final DateTime? timeCreate;
  final DateTime? timePurchase;
  final OrderStatus orderStatus;
  final List<OrderDetailRowBuilder> orderDetailProducts;
  final List<OrderDetailTotal> orderDetailTotals;
  final String titleButton1;
  final String titleButton2;
  final VoidCallback action1;
  final VoidCallback action2;
  final bool isOnlyButton1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (!ConfigStore.to.screenWidth.isMobile) {
          return _content();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(S.current.Danh_sach_don_hang),
            titleTextStyle: TextStyles.title1.copyWith(
              color: AppColor.black800,
            ),
            centerTitle: true,
            leading: SizedBox(
              height: 56.scaleSize,
              width: 56.scaleSize,
              child: IconButton(
                onPressed: context.popNavigator,
                icon: Icon(
                  CustomIcons.arrow_left,
                  color: AppColor.black800,
                  size: IconSizes.sm,
                ),
              ),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          body: _content(),
        );
      },
    );
  }

  Widget _content() {
    return Stack(
      children: <Widget>[
        ScrollConfiguration(
          behavior: MyBehavior(),
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: <Widget>[
              OrderDetailMobileHeader(
                totalPayment: totalPayment,
                orderCode: orderCode,
                partnerName: partnerName,
                timeCreate: timeCreate,
                timePurchase: timePurchase,
                orderStatus: orderStatus,
              ),
              OrderDetailBuilderWidget(
                rows: orderDetailProducts,
              ),
              OrderDetailTotalWidget(
                rows: orderDetailTotals,
              ),
              SliverToBoxAdapter(child: VSpace(50.scaleSize)),
            ],
          ),
        ),
        OrderDetailActionButton(
          titleButton1: titleButton1,
          titleButton2: titleButton2,
          action1: action1,
          action2: action2,
          isOnlyButton1: isOnlyButton1,
        ),
      ],
    );
  }
}
