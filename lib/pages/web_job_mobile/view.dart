import 'dart:async';

import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/router/router.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    Get.delete<WebJobMobileController>();
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
        btnOkOnPress: () => context.goNamed(ScreenRouter.home.name),
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
        backgroundColor: AppColor.primary,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Obx(
        () => Visibility(
          visible: _state.fakeCount != null,
          child: FloatingActionButton.small(
            backgroundColor: AppColor.yellowColor,
            onPressed: () {},
            child: Text(
              (_state.fakeCount ?? 0) > 0 ? _state.fakeCount.toString() : 'Wait',
              style: const TextStyle(
                fontSize: 12.0,
                color: AppColor.black800,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          VSpace.xs,
          Obx(
            () => Visibility(
              visible: _state.job != null && _state.showCopyKeyword,
              child: CustomButton.outlineWithIcon(
                clickColor: AppColor.errorColor,
                textColor: AppColor.errorColor,
                iconColor: AppColor.errorColor,
                borderColor: AppColor.errorColor,
                background: AppColor.errorColor.withOpacity(0.05),
                height: 36.0,
                width: 280.0,
                radius: 16.0,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                onPressed: () => Clipboard.setData(ClipboardData(text: _state.job?.keyWord ?? '')),
                text: "Nhấn vào đây để Copy từ khóa",
                textStyle: const TextStyle(
                  fontSize: 14.0,
                  color: AppColor.errorColor,
                  fontWeight: FontWeight.bold,
                ),
                icon: Icons.copy,
              ),
            ),
          ),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse("https://www.google.com/"),
              ),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                ),
              ),
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                // if (url.toString().contains(_state.job?.url ?? '#####')) {
                //   _controller.setCountTargetWeb();
                // }
              },
              onWebViewCreated: _controller.setWebViewController,
              onScrollChanged: (controller, x, y) async {
                final url = await controller.getUrl();
                if (url == null || url.toString().contains(_state.job?.url ?? '#####')) {
                  return;
                }
                if (url.host == 'www.google.com' && url.path == '/search') {
                  _controller.setSearchResultHint();
                }
              },
              onLoadStop: (InAppWebViewController controller, Uri? url) async {
                if (url == null) return;
                if (url.toString().contains(_state.job?.url ?? '#####')) {
                  _controller.setCountTargetWeb();
                  return;
                }
                if (url.host == 'www.google.com') {
                  url.path == '/search'
                      ? _controller.setSearchResultHint()
                      : _controller.setSearchKeyHint();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
