import 'dart:async';

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

  Future<void> _onTapGetJob() async {
    Loading.openAndDismissLoading(
      () => _controller.getJob().then(
            (_) {
              setState(() {});
              Future.delayed(const Duration(seconds: 15), _controller.state.removeJob);
            },
          ),
    );
  }

  Future<void> _onTapStartJobFake() async {
    final jobFake = Job(
      id: 1,
      url: 'https://thongnhat.com.vn/xe/xe-dap-nam',
      money: 1,
      image: "https://www.facebook.com/ThongNhat1960",
      time: 5
    );
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebJobMobilePage(
          job: jobFake,
          currentId: 0,
        ),
      ),
    );
    _controller.state.setCurrentJob(const CurrentJobResponse());
  }

  Future<void> _onTapStartJob() async {
    if (_controller.state.job == null) {
      CustomToast.noty(msg: 'Chưa nhận nhiệm vụ');
      return;
    }
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebJobMobilePage(
          job: _controller.state.job,
          currentId: _controller.state.currentId,
        ),
      ),
    );
    _controller.state.setCurrentJob(const CurrentJobResponse());
  }

  void _onTapRemoveJob() {
    if (_controller.state.job == null) {
      CustomToast.noty(msg: 'Chưa nhận nhiệm vụ');
      return;
    }
    _controller.cancelJob().then((value) => CustomToast.success(msg: 'Xoá thành công'));
  }

  Widget _emptyJob({required bool missionOver}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EmptyWidget(
          // hideBackgroundAnimation: true,
          packageImage: missionOver ? PackageImage.Image_1 : PackageImage.Image_3,
          title: missionOver ? 'Hết nhiệm vụ' : 'Chưa nhận nhiệm vụ',
          subTitle: missionOver ? 'Vui lòng chờ, hoặc tải lại' : 'Vui lòng ấn nút "Nhận nhiệm vụ"',
          titleTextStyle: TextStyle(
            fontSize: 18,
            color: AppColor.primary.withOpacity(0.8),
            fontWeight: FontWeight.w500,
          ),
          subtitleTextStyle: TextStyle(
            fontSize: 14,
            color: AppColor.primary.withOpacity(0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: CustomButton.fullColorWithIcon(
            onPressed: _onTapStartJobFake,
            radius: 12,
            text: missionOver ? 'Tải lại' : 'Nhận nhiệm vụ',
            icon: missionOver ? Icons.refresh : Icons.work_history,
            background: AppColor.primary,
            textStyle: const TextStyle(
              fontSize: 16,
              color: AppColor.white,
              fontWeight: FontWeight.w500,
            ),
            iconSize: 20,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Làm nhiệm vụ', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.primary,
      ),
      backgroundColor: AppColor.primaryBackgroundSuperLight,
      body: Obx(
        () => Column(
          children: [
            if (_currentId != null && _currentId != -1)
              TabletHeader(
                isHaveJob: _currentId != null && _currentId != -1,
                clickGetJob: _onTapGetJob,
                startJob: _onTapStartJob,
                removeJob: _onTapRemoveJob,
              ),
            if (_currentId == -1 || _currentId == null)
              Expanded(
                child: _emptyJob(missionOver: _job == null),
              ),
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
