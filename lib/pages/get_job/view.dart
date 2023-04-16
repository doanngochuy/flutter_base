import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/pages/pages.dart';
import 'package:EMO/pages/web_job_mobile/index.dart';
import 'package:empty_widget/empty_widget.dart';
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
    if (_controller.state.job == null) {
      CustomToast.noty(msg: 'Chưa nhận nhiệm vụ');
      return;
    }
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
    if (_controller.state.job == null) {
      CustomToast.noty(msg: 'Chưa nhận nhiệm vụ');
      return;
    }
    // _controller.removeJob().then((value) => setState(() {}));
  }

  Widget _emptyJob({required bool missionOver}) {
    return Expanded(
      child: EmptyWidget(
        packageImage: missionOver ? PackageImage.Image_1 : PackageImage.Image_3,
        title: missionOver ? 'Hết nhiệm vụ' : 'Chưa nhận nhiệm vụ',
        subTitle: missionOver ? 'Vui lòng chờ, hoặc tải lại' : 'Vui lòng ấn nút "Nhận nhiệm vụ"',
        titleTextStyle: TextStyle(
          fontSize: 18,
          color: AppColor.successColor.withOpacity(0.8),
          fontWeight: FontWeight.w500,
        ),
        subtitleTextStyle: TextStyle(
          fontSize: 14,
          color: AppColor.successColor.withOpacity(0.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Làm nhiệm vụ', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.successColor,
      ),
      backgroundColor: AppColor.primaryBackgroundSuperLight,
      body: Obx(
        () => Column(
          children: [
            TabletHeader(
              isHaveJob: _currentId != null && _currentId != -1,
              clickGetJob: _onTapGetJob,
              startJob: _onTapStartJob,
              removeJob: _onTapRemoveJob,
            ),
            if (_currentId == -1 || _currentId == null) _emptyJob(missionOver: _job == null),
            if (_job != null && _currentId != null && _currentId != -1)
              SingleChildScrollView(
                child: ContentJob(job: _job!),
              ),
          ],
        ),
      ),
    );
  }
}
