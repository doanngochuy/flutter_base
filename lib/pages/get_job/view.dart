import 'package:flutter/material.dart';
import 'package:flutter_base/common/entities/entities.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/pages/pages.dart';
import 'package:flutter_base/pages/web_job_mobile/index.dart';
import 'package:get/get.dart';

import 'widget/widget.dart';

class GetJobPage extends StatefulWidget {
  const GetJobPage({Key? key}) : super(key: key);

  @override
  State<GetJobPage> createState() => _GetJobPageState();
}

class _GetJobPageState extends State<GetJobPage> {
  final _controller = Get.put(GetJobController());

  Job? get _job => _controller.state.job;

  int? get _currentId => _controller.state.currentId;

  @override
  void initState() {
    super.initState();
  }

  void _onTapGetJob() {
    Loading.openAndDismissLoading<bool>(() async {
      await _controller.getJob();
      setState(() {});
      return true;
    });
  }

  void _onTapStartJob() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => WebJobMobilePage(job: _controller.state.job)));
  }

  void _onTapRemoveJob() {
    // _controller.removeJob().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: [
            TabletHeader(
              clickGetJob: _onTapGetJob,
              startJob: _onTapStartJob,
              removeJob: _onTapRemoveJob,
            ),
            if (_currentId == -1) const Text('Tạm thời hết nhiệm vụ, quay lại sau!'),
            if (_job != null && _currentId != null && _currentId != -1) ContentJob(job: _job!)
          ],
        ),
      ),
    );
  }
}
