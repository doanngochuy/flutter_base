import 'package:flutter/material.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/models/models.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/common/utils/utils.dart';

class OrderDetailHeaderCell {
  final int flex;
  final String title;
  final TextAlign align;

  OrderDetailHeaderCell({
    required this.flex,
    required this.title,
    this.align = TextAlign.center,
  });
}

Widget orderDetailHeaderCellWidget({
  required flex,
  required title,
  align = TextAlign.center,
}) =>
    Expanded(
      flex: flex,
      child: Text(
        title,
        textAlign: align,
        maxLines: 2,
        style: TextStyles.title1.copyWith(
          color: AppColor.black800,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

Widget orderTagStatusWidget(
  OrderStatus status, {
  double? fontSize,
  EdgeInsets? padding,
}) {
  const double opacity = 0.6;
  late Color color;
  late String text;
  switch (status) {
    case OrderStatus.pending:
      color = AppColor.yellowColor.withOpacity(opacity);
      text = S.current.Dang_xu_ly;
      break;
    case OrderStatus.order:
      color = AppColor.orange.withOpacity(opacity);
      text = S.current.Dat_hang;
      break;
    case OrderStatus.done:
      color = AppColor.successColor.withOpacity(opacity);
      text = S.current.Hoan_thanh;
      break;
    case OrderStatus.cancel:
      color = AppColor.errorColor.withOpacity(opacity);
      text = S.current.Huy;
      break;
  }
  return Container(
    padding: padding ?? EdgeInsets.all(Insets.sm),
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: Corners.medBorder,
      border: Border.all(color: color, width: Strokes.thick / 2),
    ),
    child: Text(
      text,
      style: TextStyles.title1.copyWith(
        color: color,
        fontSize: fontSize,
      ),
    ),
  );
}

class OrderDetailMobileHeader extends StatelessWidget {
  OrderDetailMobileHeader({
    Key? key,
    required this.totalPayment,
    required this.orderCode,
    this.partnerName,
    this.timeCreate,
    this.timePurchase,
    required this.orderStatus,
  }) : super(key: key);

  final double totalPayment;
  final String orderCode;
  final String? partnerName;
  final DateTime? timeCreate;
  final DateTime? timePurchase;
  final OrderStatus orderStatus;

  final List<OrderDetailHeaderCell> _headerItems = [
    OrderDetailHeaderCell(
      flex: 5,
      title: S.current.Ten,
      align: TextAlign.left,
    ),
    OrderDetailHeaderCell(
      flex: 4,
      title: S.current.Don_gia,
    ),
    OrderDetailHeaderCell(
      flex: 4,
      title: S.current.So_luong,
    ),
    OrderDetailHeaderCell(
      flex: 4,
      title: S.current.Tong_cong,
      align: TextAlign.right,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leadingWidth: 0,
      expandedHeight: 252.scaleSize,
      toolbarHeight: 44.scaleSize,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        expandedTitleScale: 1,
        title: Padding(
          padding: EdgeInsetsDirectional.only(
            start: Insets.med,
            end: Insets.med,
          ),
          child: _headerItemsWidget(),
        ),
        background: _detailCard(),
      ),
    );
  }

  Widget _headerItemsWidget() => Container(
        padding: EdgeInsets.only(
          top: Insets.sm,
          bottom: Insets.med,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColor.orange,
              width: Strokes.thin,
              style: BorderStyle.solid,
            ),
          ),
          color: AppColor.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _headerItems
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

  Widget _detailCardItem({
    required String left,
    required String right,
    Color colorLeft = AppColor.grey600,
    Color colorRight = AppColor.grey600,
    FontWeight fountWeightLeft = FontWeight.normal,
  }) =>
      Padding(
        padding: EdgeInsets.only(bottom: Insets.xs),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              left,
              style: TextStyles.title1.copyWith(
                color: colorLeft,
                fontWeight: fountWeightLeft,
              ),
            ),
            Text(
              right,
              style: TextStyles.title1.copyWith(
                color: colorRight,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      );

  Widget _detailCard() => Padding(
        padding: EdgeInsets.all(Insets.med),
        child: Align(
          alignment: Alignment.topCenter,
          child: Stack(
            children: <Widget>[
              CustomCard.card1(
                child: Container(
                  height: 192.scaleSize,
                  padding: EdgeInsets.all(Insets.med),
                  decoration: const BoxDecoration(
                    color: AppColor.grey300,
                    borderRadius: Corners.medBorder,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        S.current.Tong_cong,
                        style: TextStyles.title1.copyWith(
                          color: AppColor.grey600,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        truncateNumberToString(totalPayment),
                        style: TextStyles.h2.copyWith(
                          color: AppColor.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      VSpace(Insets.lg),
                      _detailCardItem(
                        left: S.current.Ma_don,
                        right: S.current.Ngay_tao,
                      ),
                      _detailCardItem(
                        left: orderCode,
                        colorLeft: AppColor.black800,
                        fountWeightLeft: FontWeight.bold,
                        right: timeCreate != null ? timeCreate.fullDateAndTimeStr : '',
                        colorRight: AppColor.black800,
                      ),
                      _detailCardItem(
                        left: S.current.Khach_hang,
                        right: S.current.Ngay_ban,
                      ),
                      _detailCardItem(
                        left: partnerName ?? S.current.Khach_le,
                        colorLeft: AppColor.black800,
                        right: timePurchase != null ? timePurchase.fullDateAndTimeStr : '',
                        colorRight: AppColor.black800,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: Insets.lg,
                left: Insets.sm,
                child: Center(
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(-Insets.lg / 360), // 360 degrees
                    child: orderTagStatusWidget(orderStatus),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
