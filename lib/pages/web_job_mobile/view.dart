import 'dart:async';

import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/router/router.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'index.dart';

class WebJobMobilePage extends StatefulWidget {
  const WebJobMobilePage({Key? key, this.job, this.currentId}) : super(key: key);
  final Job? job;
  final int? currentId;

  @override
  State<WebJobMobilePage> createState() => _WebJobMobilePageState();
}

class _WebJobMobilePageState extends State<WebJobMobilePage> {
  final _controller = Get.put(WebJobMobileController());

  GetJobState get _state => _controller.state;

  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _controller.initState(widget.job, widget.currentId);
    _subscription = _state.statusJobStream.listen((value) {
      switch (value) {
        case JobStatus.done:
          _showConfirmFinish();
          _state.setJobStatus(JobStatus.none);
          break;
        case JobStatus.error:
          _showConfirmError();
          _state.setJobStatus(JobStatus.none);
          break;
        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _showConfirmFinish() => AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.success,
        showCloseIcon: true,
        title: 'Thành công',
        desc: 'Bạn đã hoàn thành công việc này, trở lại màn hình chính?',
        btnOkOnPress: () => context.goNamed(ScreenRouter.jobDone.name),
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) => context.pop(),
      ).show();

  void _showConfirmError() => AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'Không thành công',
        desc: 'Có lỗi xảy ra khi gửi kết quả, trở lại màn hình chính?',
        btnOkOnPress: context.pop,
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();

  AppBar _appBar() => AppBar(
        title: const Text("Nhiệm vụ", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.primaryBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: context.pop,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Obx(
              () => Text(
                _state.tip,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse("https://www.google.com/"),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
          ),
        ),
        onUpdateVisitedHistory: (controller, url, androidIsReload) {
          if (url.toString().contains(_controller.state.job?.url ?? '#####')) {
            _controller.setCountTargetWeb();
          }
        },
        onWebViewCreated: _controller.setWebViewController,
        onLoadStop: (InAppWebViewController controller, Uri? url) async {
          if (url == null) return;
          if (url.toString().contains(_controller.state.job?.url ?? '#####')) {
            _controller.setCountTargetWeb();
            return;
          }
          if (url.host == 'www.google.com') {
            if (url.path == '/search') {
              _controller.setSearchResultHint();
            } else {
              _controller.setSearchKeyHint();
            }
          }
        },
      ),
    );
  }
}
