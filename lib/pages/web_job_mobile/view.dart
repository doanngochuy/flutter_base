import 'package:flutter/material.dart';
import 'package:flutter_base/common/entities/entities.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'index.dart';

class WebJobMobilePage extends StatefulWidget {
  const WebJobMobilePage({Key? key, this.job}) : super(key: key);
  final Job? job;

  @override
  State<WebJobMobilePage> createState() => _WebJobMobilePageState();
}

class _WebJobMobilePageState extends State<WebJobMobilePage> {
  final _controller = Get.put(WebJobMobileController());

  @override
  void initState() {
    super.initState();
    _controller.setJob(widget.job);
    _controller.state.isFinishJobStream.listen((event) => {_showConfirmFinish()});
  }

  void _showConfirmFinish() {
    CustomDialog.warning(
      context,
      title: "Thành công",
      content: "Bạn đã hoàn thành công việc này, trở lại màn hình chính?",
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
        onWebViewCreated: _controller.setWebViewController,
        onLoadStop: (InAppWebViewController controller, Uri? url) async {
          if (url == null) return;
          if (url.host == 'www.google.com') {
            if (url.path == '/search') {
              _controller.setSearchResultHint();
            } else {
              _controller.setSearchKeyHint();
            }
            return;
          }

          if (url.toString().contains(_controller.state.job?.url ?? '#####')) {
            _controller.setCountTargetWeb();
          }
        },
      ),
    );
  }
}
