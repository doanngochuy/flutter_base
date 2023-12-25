import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:flutter/material.dart';

class TabletHeader extends StatelessWidget {
  const TabletHeader({
    Key? key,
    required this.isHaveJob,
    required this.clickGetJob,
    required this.startJob,
    required this.removeJob,
  }) : super(key: key);

  final bool isHaveJob;
  final VoidCallback clickGetJob;
  final VoidCallback startJob;
  final VoidCallback removeJob;

  Widget _renderButton({
    required String title,
    required IconData iconData,
    Color color = AppColor.primary,
    required Function() onTap,
    Key? key,
  }) {
    return InkWell(
      key: key,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Insets.sm, vertical: Insets.xs),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: Corners.lgBorder,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            VSpace(2.scaleSize),
            Icon(iconData, size: 28.scaleSize, color: color),
            SizedBox(
              height: Height.med,
              child: Center(
                child: Text(
                  title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyles.body1.copyWith(
                    height: 1.2,
                    color: color,
                  ),
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
        VSpace.xs,
        Row(
          children: [
            HSpace.sm,
            Expanded(
              child: _renderButton(
                title: isHaveJob ? "Refresh" : "Nhận nhiệm vụ",
                iconData: isHaveJob ? Icons.refresh : Icons.add_circle_outline,
                onTap: clickGetJob,
                color: AppColor.primary,
              ),
            ),
            HSpace.sm,
            Expanded(
              child: _renderButton(
                title: "Bắt đầu làm",
                iconData: Icons.start_rounded,
                onTap: startJob,
                color: isHaveJob ? AppColor.primary : AppColor.grey600,
              ),
            ),
            HSpace.sm,
            Expanded(
              child: _renderButton(
                title: "Bỏ qua nhiệm vụ",
                iconData: Icons.cancel_outlined,
                onTap: removeJob,
                color: isHaveJob ? AppColor.errorColor : AppColor.grey600,
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
