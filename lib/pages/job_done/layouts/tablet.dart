import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/styles/styles.dart';

import '../controller.dart';
import '../widgets/widgets.dart';

class JobDoneTablet extends StatelessWidget {
  JobDoneTablet({Key? key}) : super(key: key);

  final JobDoneController _controller = JobDoneController.to;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.grey300WithOpacity500,
                border: const Border(
                  right: BorderSide(
                    color: AppColor.grey300,
                  ),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Obx(
                    () => JobListHeaderWidget(
                      countItem: _controller.state.count,
                      totalMoney: _controller.state.totalMoney,
                    ),
                  ),
                  const Expanded(
                    child: JobList(),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Obx(
              () {
                return SizedBox(
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      S.current.Hien_thi_chi_tiet_don_hang,
                      style: TextStyles.title1.copyWith(color: AppColor.grey600),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
