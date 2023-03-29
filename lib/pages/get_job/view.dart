import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/pages/pages.dart';
import 'package:EMO/pages/web_job_mobile/index.dart';
import 'package:flutter/material.dart';
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
      await _controller.getJob().then((value) => setState(() {}));
      return true;
    });
  }

  void _onTapStartJob() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebJobMobilePage(
          job: _controller.state.job,
          currentId: _controller.state.currentId,
        ),
      ),
    );
  }

  void _onTapRemoveJob() {
    // _controller.removeJob().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Làm nhiệm vụ', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.successColor,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              TabletHeader(
                isHaveJob: _currentId != null && _currentId != -1,
                clickGetJob: _onTapGetJob,
                startJob: _onTapStartJob,
                removeJob: _onTapRemoveJob,
              ),
              if (_currentId == -1) const Text('Tạm thời hết nhiệm vụ, quay lại sau!'),
              if (_job != null && _currentId != null && _currentId != -1) ContentJob(job: _job!)
            ],
          ),
        ),
      ),
    );
  }
}
