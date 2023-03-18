import 'package:flutter_base/common/theme/theme.dart';
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

  void setJob(Job? job) => state.job = job;

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
    _webViewController?.evaluateJavascript(source: """    
        const searchForm = document.querySelector('form#tsf');
          
        const keyword = "${state.job?.keyWord}";
        const urlToFind = "${state.job?.url}"
        
        const elements = document.getElementsByTagName("a");
        
        for (let i = 0; i < elements.length; i++) {
          if(elements[i].href.includes(urlToFind)) {
            elements[i].style.backgroundColor = "yellow";
          }
        }  
      """);
  }

  void setCountTargetWeb() {
    _webViewController?.addJavaScriptHandler(
        handlerName: Event.startJob.name,
        callback: (args) {
          print("Start job ");
          startJob();
        });

    _webViewController?.addJavaScriptHandler(
        handlerName: Event.finishJob.name,
        callback: (args) {
          print("Finish job a");
          finishJob(args[0].toString());
        });

    final js = """
            var countdownDiv = document.createElement("div");
            countdownDiv.id = "countdown";
            countdownDiv.style.position = "fixed";
            countdownDiv.style.bottom = "10px";
            countdownDiv.style.right = "10px";
            countdownDiv.style.backgroundColor = "#fff";
            countdownDiv.style.padding = "10px";
            countdownDiv.style.borderRadius = "5px";
            countdownDiv.style.boxShadow = "0 0 10px rgba(0, 0, 0, 0.3)";
            countdownDiv.style.zIndex = "9999";
            document.body.appendChild(countdownDiv);

            var startTime = ${state.job?.time ?? 0};
            var endTime = 0;

            function formatTime(time) {
              var minutes = Math.floor(time / 60);
              var seconds = time - minutes * 60;

              if (seconds < 10) {
                seconds = "0" + seconds;
              }

              return minutes + ":" + seconds;
            }

            function updateCountdown() {
              startTime--;

              if (startTime < endTime) {
                clearInterval(interval);
                countdownDiv.innerHTML = "Hoàn thành, vui lòng quay lại!";
                const htmlElement = document.querySelector('${state.startJobResponse?.key ??
        '#####'}');

                window.flutter_inappwebview.callHandler('${Event.finishJob.name}', htmlElement.id);
                return;
              }

              countdownDiv.innerHTML = formatTime(startTime);
            }

            var interval = setInterval(updateCountdown, 1000);
            
            window.flutter_inappwebview.callHandler('${Event.startJob.name}');
          """;

    _webViewController?.evaluateJavascript(source: js);
  }

  void startJob() {
    JobStore.to.startJob(state.job?.id ?? 0, state.currentId ?? 0).then(
          (value) {
            print("Start job ${value.key}");

            state.startJobResponse = value;
      },
    ).catchError(print);
  }

  void finishJob(String valuePage) {

    if (state.startJobResponse == null) return;
    print("Finish jobq  $valuePage");
    JobStore.to.finishJob(state.startJobResponse!.token, valuePage).then(
          (value) {
            print("Finish job ${value.key}");
        state.setIsFinishJob(true);
      },
    ).catchError(
            (e) {
              print("Finish job e ${e}");

              CustomToast.error(msg: "Có lỗi xảy ra, vui lòng thử lại sau! ($e)");
        });
  }
}
