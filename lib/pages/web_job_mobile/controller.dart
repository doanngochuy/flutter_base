import 'dart:async';

import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../common/entities/entities.dart';
import '../../common/store/store.dart';
import 'state.dart';

class WebJobMobileController extends GetxController {
  static WebJobMobileController get to => Get.find();

  final state = GetJobState();

  WebJobMobileController();

  InAppWebViewController? _webViewController;

  StreamSubscription? _streamSubscription;

  void initState(Job? job, int? currentId) {
    state.job = job;
    state.currentId = currentId;
    state.setTip(' Copy từ khóa \'${state.job?.keyWord ?? ""}\' và dán vào ô tìm kiếm');
  }

  @override
  void onClose() {
    _streamSubscription?.cancel();
    super.onClose();
  }

  void setWebViewController(InAppWebViewController controller) => _webViewController = controller;

  void setSearchKeyHint() {
    _webViewController?.evaluateJavascript(source: """
      const searchBox = document.querySelector('input[name="q"]');
      const logo = document.querySelector('#tsf');
      var keyWordHint = document.querySelector('#${state.keyWordHintId}');          
      if (logo && searchBox && !keyWordHint) {
        var container = document.createElement('div');
        container.id = '${state.keyWordHintId}';
        container.style.marginTop = '10px';
        container.style.textAlign = 'center';
        container.style.color = 'red';
        container.style.fontSize = '16px';
        container.style.fontStyle = 'italic';
        container.style.border = "2px solid red";
        container.innerText = 'Nhập "${state.job?.keyWord}"';
        logo.parentNode?.insertBefore(container, logo);
        searchBox.setAttribute('placeholder', '${state.job?.keyWord}');
      }
      """);
  }

  void setSearchResultHint() {
    state.setShowCopyKeyword(false);
    const arrowDiv = "arrowDiv";
    const otherButton = "otherButton";
    const otherButtonVisible = "otherButtonVisible";
    const linkViewStatus = "linkViewStatus";
    const elements = "elements";
    const styleText = "styleText";

    const textDownStyle =
        '<div style="width: 30px; text-align: center; color: black; font-size: 14px;">Kéo xuống</div> <div style="position: relative; width: 0; height: 0px; margin-top: 2px; border-left: 20px solid transparent; border-right: 20px solid transparent; border-top: 12px solid white;"/>';
    const textUpStyle =
        '<div style="width: 0; height: 0; border-left: 15px solid transparent; border-right: 15px solid transparent; border-bottom: 25px solid white; margin-left: 7.5px;"></div> <div style="width: 50px; text-align: center; color: black; font-size: 14px;">Kéo lên</div>';
    const textClickStyle =
        '<div style="width: 150px; text-align: center; color: black; font-size: 14px;">Click nút <br> Kết quả tìm kiếm khác</div>';
    if (state.firstResultHint) {
      // _webViewController?.addJavaScriptHandler(
      //     handlerName: "aaaa",
      //     callback: (args) {
      //      debugConsoleLog("value ${args[0]} ${args[1]} ${args[2]}");
      //     });2

       const initJs = """
            var $arrowDiv = document.createElement("div");
            var $otherButton = null;
            var $elements = false;
            var $linkViewStatus = 0; //0 - not visible, 1 - visible, 2 - over
            var $styleText = 0;

            function inViewport(element) {//0 - not visible, 1 - visible, 2 - over
                if (!element) return false;
                const rect = element.getBoundingClientRect();
                let viewPortBottom = window.innerHeight || document.documentElement.clientHeight;
                                
                if (rect.top > 0 && rect.top < viewPortBottom) return 1;
                
                if (rect.top < 0) return 2;
                
                return 0;
            }
            try {
              $arrowDiv.id = "countdown";
              $arrowDiv.style.position = "fixed";
              $arrowDiv.style.bottom = "80px";
              $arrowDiv.style.left = "20px";
              $arrowDiv.style.width = "40px";
              $arrowDiv.style.height = "36px";
              $arrowDiv.style.backgroundColor = "#FFD700";
              $arrowDiv.style.padding = "8px";
              $arrowDiv.style.borderRadius = "20%";
              $arrowDiv.style.boxShadow = "0 0 10px rgba(0, 0, 0, 0.3)";
              $arrowDiv.style.zIndex = "9000";
              $arrowDiv.style.fontWeight = "bold";
              $arrowDiv.innerHTML = '$textDownStyle';
              document.body.appendChild($arrowDiv);  
            } catch (e) {}
          """;
      _webViewController?.evaluateJavascript(source: initJs);

      state.setTip("Vào trang '${state.job?.baseUrl ?? ""}...'(Tô vàng)");

      state.firstResultHint = false;
    }

    _webViewController?.evaluateJavascript(source: """
        $elements = document.getElementsByTagName("a");
        $linkViewStatus = 0;
        for (let i = 0; i < $elements.length; i++) {
          let element = $elements[i];
          if(element.href.includes("${state.job?.url}") && inViewport(element) != 0) {
            element.style.backgroundColor = "yellow";
            $linkViewStatus = inViewport(element);
          }
        }
        
        $otherButton = document.querySelector('a[aria-label="Kết quả tìm kiếm khác"]');
        $otherButtonVisible = inViewport($otherButton) != 0;
        
        if ($otherButtonVisible && $linkViewStatus == 0 && $styleText != 3) {
          $styleText = 3;
          $otherButton.style.backgroundColor = "yellow";
          $arrowDiv.style.display = "block";
          $arrowDiv.style.width = "160px";
          $arrowDiv.innerHTML = '$textClickStyle';
        }
        
        if (!$otherButtonVisible && $linkViewStatus == 2 && $styleText != 2) {
          $styleText = 2;
          $arrowDiv.style.display = "block";
          $arrowDiv.style.width = "40px";
          $arrowDiv.innerHTML = '$textUpStyle';
        }
        
        if (!$otherButtonVisible && $linkViewStatus == 1 && $styleText != 1) {
          $styleText = 1;
          $arrowDiv.style.display = "none";
        }
        
        if (!$otherButtonVisible && $linkViewStatus == 0 && $styleText != 0) {
          $styleText = 0;
          $arrowDiv.style.display = "block";
          $arrowDiv.style.width = "40px";
          $arrowDiv.innerHTML = '$textDownStyle';
        }
        
        """);
  }

  Future setCountTargetWeb() async {
    if (state.jobStatus != JobStatus.none) return;
    state.setJobStatus(JobStatus.target);

    final startSuccessfully = await startJob();

    if (!startSuccessfully) return;

    _setFakeCount();
    state.setTip(" Kéo xuống cuối trang web và chờ khi đếm ngược hết");
  }

  void _setFakeCount() {
    state.setFakeCount(state.job?.time ?? 10);
    _streamSubscription = Stream.periodic(const Duration(seconds: 1), (i) => i)
        .take(state.job?.time ?? 0)
        .where((e) => e >= 0)
        .listen(
      (count) {
        state.setFakeCount(state.fakeCount! - 1);
        if ((state.fakeCount ?? 0) <= 0) {
          setFinishJob();
        }
      },
    );
  }

  void setFinishJob() {
    if (state.startJobResponse == null) return;
    if ([JobStatus.none, JobStatus.finish, JobStatus.error].contains(state.jobStatus)) return;
    state.setJobStatus(JobStatus.finish);
    switch (state.job?.keyPage) {
      case JobKeyPage.title:
        titleFinish();
        break;
      default:
        queryIndexFinish();
    }
  }

  void titleFinish() async {
    final title = await _webViewController?.getTitle();

    if (title == null) {
      state.setJobStatus(JobStatus.error);
      return;
    }
    Loading.openAndDismissLoading(() => finishJob(title));
  }

  void queryIndexFinish() {
    _webViewController?.addJavaScriptHandler(
        handlerName: Event.finishJob.name,
        callback: (args) {
          final valuePage = args[0].toString();
          if (valuePage == 'Error') {
            state.setJobStatus(JobStatus.error);
            return;
          }
          Loading.openAndDismissLoading(() => finishJob(valuePage));
        });

    final js = """
            try {
              if (typeof countdownDiv !== 'undefined' && countdownDiv !== null) countdownDiv.innerHTML = "Waiting!";
              const htmlElement = document.querySelector('${state.startJobResponse!.key}');
              window.flutter_inappwebview.callHandler('${Event.finishJob.name}', htmlElement.id);
            } catch (error) {
              window.flutter_inappwebview.callHandler('${Event.finishJob.name}', 'Error');
            }
          """;

    final jsNumber = """
              try {
                if (typeof countdownDiv !== 'undefined' && countdownDiv !== null) countdownDiv.innerHTML = "Waiting!";
                const styleSheets = document.styleSheets;
                if (styleSheets) {
                  const styleSheet = styleSheets[${state.startJobResponse!.key}];
                  const cssRules = styleSheet.cssRules;
                  window.flutter_inappwebview.callHandler('${Event.finishJob.name}', cssRules[0].selectorText);
                }
              } catch (error) {
                window.flutter_inappwebview.callHandler('${Event.finishJob.name}', 'Error');
              }
          """;

    _webViewController?.evaluateJavascript(
        source: state.startJobResponse!.key.isNum ? jsNumber : js);
  }

  Future<bool> startJob() async {
    if (state.jobStatus != JobStatus.target) return false;
    try {
      state.setJobStatus(JobStatus.start);
      final result = await JobStore.to.startJob(state.job?.id ?? 0, state.currentId ?? 0);
      state.startJobResponse = result;
      return true;
    } catch (e) {
      Logger.write(e.toString());
    }
    return false;
  }

  Future finishJob(String valuePage) =>
      JobStore.to.finishJob(state.startJobResponse!.token, valuePage).then(
        (value) {
          state.setJobStatus(JobStatus.done);
        },
      ).catchError((e) {
        state.setJobStatus(JobStatus.error);
      });
}
