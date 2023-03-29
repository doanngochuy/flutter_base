import 'package:EMO/common/styles/styles.dart';
import 'package:flutter/material.dart';

import 'layouts.dart';

class JobDoneWeb extends StatelessWidget {
  const JobDoneWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.grey300,
      child: Row(
        children: <Widget>[
          // const WebFilterWidget(),
          Expanded(child: JobDoneTablet()),
        ],
      ),
    );
  }
}
