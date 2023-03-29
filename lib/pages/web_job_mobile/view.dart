import 'package:flutter/material.dart';
import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/logger.dart';
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

  @override
  void initState() {
    super.initState();
    _controller.initState(widget.job, widget.currentId);
    _state.statusJobStream.listen((value) {
      switch(value) {
        case JobStatus.done:
          _showConfirmFinish();
          break;
        case JobStatus.error:
          _showConfirmError();
          break;
        default:
          break;
      }
    });
  }

  void _showConfirmFinish() {
    CustomDialog.warning(
      context,
      title: "Thành công",
      content: "Bạn đã hoàn thành công việc này, trở lại màn hình chính?",
      onSelectWarningBtn: context.pop,
    );
  }

  void _showConfirmError() {
    CustomDialog.warning(
      context,
      title: "Không thành công",
      content: "Có lỗi xảy ra khi gửi kết quả, trở lại màn hình chính?",
      onSelectWarningBtn: context.pop,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          print('url5: ${url.toString()} - ${_controller.state.job?.url ?? '#####'}');
          if (url.toString().contains(_controller.state.job?.url ?? '#####')) {
            _controller.setCountTargetWeb();
          }
        },
        onWebViewCreated: _controller.setWebViewController,
        onLoadStop: (InAppWebViewController controller, Uri? url) async {
          if (url == null) return;
          if (url.toString().contains(_controller.state.job?.url ?? '#####')) {
            _controller.setCountTargetWeb();
          }
          if (url.host == 'www.google.com') {
            if (url.path == '/search') {
              _controller.setSearchResultHint();
            } else {
              _controller.setSearchKeyHint();
            }
            return;
          }
        },
      ),
    );
  }
}
