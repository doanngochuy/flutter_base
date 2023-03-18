import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/common/utils/utils.dart';

class TabletHeader extends StatefulWidget {
  const TabletHeader({
    Key? key,
    required this.clickGetJob,
    required this.startJob,
    required this.removeJob,
  }) : super(key: key);
  final VoidCallback clickGetJob;
  final VoidCallback startJob;
  final VoidCallback removeJob;


  @override
  State<TabletHeader> createState() => _TabletHeaderState();
}

class _TabletHeaderState extends State<TabletHeader> {

  Widget _renderButton(String title, IconData iconData, Function() onTap, {Key? key}) {
    return InkWell(
      key: key,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Insets.sm, vertical: Insets.xs),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: Corners.lgBorder,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            VSpace(2.scaleSize),
            Icon(iconData, size: 28.scaleSize, color: Colors.black),
            SizedBox(
              height: Height.med,
              child: Center(
                child: Text(
                  title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyles.body1.copyWith(height: 1.2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 2,
          color: AppColor.orange,
        ),
        Container(
          height: 52.scaleSize,
          padding: EdgeInsets.symmetric(horizontal: Insets.med, vertical: Insets.sm),
          color: Colors.white,
          child: Row(
            children: [
              Icon(
                Icons.table_chart_outlined,
                size: 25.scaleSize,
                color: AppColor.grey600,
              ),
              SizedBox(width: Insets.xs),
              Text(
                "Làm nhiệm vụ",
                textAlign: TextAlign.center,
                style: TextStyles.title1.copyWith(
                  color: AppColor.black800,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 0.5,
          color: AppColor.grey600,
        ),
        VSpace.xs,
        Row(
          children: [
            HSpace.sm,
            Expanded(
              child: _renderButton(
                "Nhận nhiệm vụ",
                Icons.attach_money,
                widget.clickGetJob,
              ),
            ),
            HSpace.sm,
            Expanded(
              child: _renderButton(
                "Bắt đầu làm",
                Icons.start_rounded,
                widget.startJob,
              ),
            ),
            HSpace.sm,
            Expanded(
              child: _renderButton(
                "Bỏ qua nhiệm vụ",
                Icons.cancel_outlined,
                widget.removeJob,
              ),
            ),
            HSpace.sm,
          ],
        ),
        VSpace.xs,
      ],
    );
  }
}
