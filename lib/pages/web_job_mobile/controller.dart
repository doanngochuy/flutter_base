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

  void initState(Job? job, int? currentId) {
    state.job = job;
    state.currentId = currentId;
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
          startJob();
        });

    _webViewController?.addJavaScriptHandler(
        handlerName: Event.timeOut.name,
        callback: (args) {
          setFinishJob();
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
                window.flutter_inappwebview.callHandler('${Event.timeOut.name}');
                return;
              }

              countdownDiv.innerHTML = formatTime(startTime);
            }

            var interval = setInterval(updateCountdown, 1000);
            
            window.flutter_inappwebview.callHandler('${Event.startJob.name}');
          """;
    _webViewController?.evaluateJavascript(source: js);
  }

  void setFinishJob() {
    if (state.startJobResponse == null) return;
    _webViewController?.addJavaScriptHandler(
        handlerName: Event.finishJob.name,
        callback: (args) {
          finishJob(args[0].toString());
        });

    final js = """
              countdownDiv.innerHTML = "Hoàn thành, vui lòng quay lại!";
              const htmlElement = document.querySelector('${state.startJobResponse?.key ?? '#####'}');
              window.flutter_inappwebview.callHandler('${Event.finishJob.name}', htmlElement.id);
          """;

    _webViewController?.evaluateJavascript(source: js);
  }

  void startJob() {
    if (state.jobStatus != JobStatus.none) return;
    state.setJobStatus(JobStatus.start);
    JobStore.to.startJob(state.job?.id ?? 0, state.currentId ?? 0).then(
      (value) {
        state.startJobResponse = value;
      },
    ).catchError(print);
  }

  void finishJob(String valuePage) {
    JobStore.to.finishJob(state.startJobResponse!.token, valuePage).then(
      (value) {
        print("Finish job ${value}");
        state.setJobStatus(JobStatus.done);
      },
    ).catchError((e) {
      print("Finish job e ${e}");

      state.setJobStatus(JobStatus.error);
    });
  }
}
