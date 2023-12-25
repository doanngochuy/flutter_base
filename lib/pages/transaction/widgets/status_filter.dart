import 'package:flutter/material.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:EMO/common/theme/theme.dart';

import '../controller.dart';

class StatusFilterWidget extends StatefulWidget {
  const StatusFilterWidget({
    Key? key,
    required this.onApply,
    required this.initStatusData,
  }) : super(key: key);

  final Function(List<Map<String, bool>>) onApply;
  final List<Map<String, bool>> initStatusData;

  @override
  State<StatusFilterWidget> createState() => _StatusFilterWidgetState();
}

class _StatusFilterWidgetState extends State<StatusFilterWidget> {
  List<Map<String, bool>> listMapNameStatusWithStatusSelected = [];

  bool isOrderingStatusSelected = false;
  bool isCancelStatusSelected = false;
  bool isDoneStatusSelected = false;

  final TransactionController controller = TransactionController.to;

  @override
  void initState() {
    super.initState();
    listMapNameStatusWithStatusSelected = [...widget.initStatusData];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemBuilder: (builderContext, index) {
              final String keyStatus = listMapNameStatusWithStatusSelected[index].keys.first;
              return CustomButton.outline(
                onPressed: () {
                  setState(() {
                    listMapNameStatusWithStatusSelected[index][keyStatus] =
                        !(listMapNameStatusWithStatusSelected[index][keyStatus] ?? false);
                  });
                },
                background: AppColor.grey300,
                textColor: listMapNameStatusWithStatusSelected[index][keyStatus] ?? false
                    ? AppColor.blueLight
                    : AppColor.black800,
                borderColor: listMapNameStatusWithStatusSelected[index][keyStatus] ?? false
                    ? AppColor.blueLight
                    : AppColor.grey300,
                text: S.current.Huy,
              );
            },
          ),
        ),
        CustomButton.fullColor(
          onPressed: () {
            widget.onApply(listMapNameStatusWithStatusSelected);
            context.popNavigator();
          },
          width: double.infinity,
          text: S.current.Ap_dung,
        )
      ],
    );
  }
}
