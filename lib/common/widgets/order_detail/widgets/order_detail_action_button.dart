import 'package:flutter/material.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/theme/theme.dart';

class OrderDetailActionButton extends StatelessWidget {
  const OrderDetailActionButton({
    Key? key,
    required this.titleButton1,
    required this.titleButton2,
    required this.action1,
    required this.action2,
    this.isOnlyButton1 = false,
  }) : super(key: key);

  final String titleButton1;
  final String titleButton2;
  final VoidCallback action1;
  final VoidCallback action2;
  final bool isOnlyButton1;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(Insets.med),
        child: Row(
          children: <Widget>[
            if (!isOnlyButton1)
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(right: Insets.med),
                  child: CustomButton.outline(
                    onPressed: action2,
                    background: AppColor.white,
                    text: titleButton2,
                    textColor: AppColor.orange,
                    borderColor: AppColor.orange,
                    clickColor: AppColor.orange,
                    maxLines: 2,
                  ),
                ),
              ),
            Expanded(
              child: CustomButton.fullColor(
                onPressed: action1,
                background: AppColor.orange,
                text: titleButton1,
                textColor: AppColor.white,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
