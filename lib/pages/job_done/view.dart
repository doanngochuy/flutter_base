import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'layouts/layouts.dart';

class JobDonePage extends StatefulWidget {
  const JobDonePage({
    Key? key,
  }) : super(key: key);

  @override
  State<JobDonePage> createState() => _JobDonePageState();
}

class _JobDonePageState extends State<JobDonePage> {
  late final JobDoneController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(JobDoneController());
    _controller.initData();
  }

  Widget _renderUI(BuildContext context) {
    return JobDoneMobile();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return _renderUI(context);
      },
    );
  }
}
