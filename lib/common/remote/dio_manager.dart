import 'package:dio/dio.dart';
import 'package:flutter_base/common/config/config.dart';
import 'package:flutter_base/common/di/injector.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/theme/theme.dart';
import 'package:flutter_base/common/utils/utils.dart';

import '../store/store.dart';

class DioManager {
  static getDio({required bool showDefaultError}) {
    String baseUrl = BuildMode.current.baseUrl;

    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      headers: getAuthorizationHeader(),
      connectTimeout: 30000,
      receiveTimeout: 30000,
    );

    Dio dio = Dio(options);

    dio.interceptors.add(CustomInterceptor(showDefaultError));

    return dio;
  }

  static Map<String, String> getAuthorizationHeader() {
    var headers = <String, String>{};
    headers['Accept'] = 'application/json';
    headers['Content-Type'] = 'application/json';
    if (AppInjector.injector.isRegistered<UserStore>() && UserStore.to.hasToken) {
      headers['Authorization'] = 'Bearer ${UserStore.to.accessToken}';
    }
    return headers;
  }
}

class CustomInterceptor implements Interceptor {
  bool showDefaultError;

  CustomInterceptor(this.showDefaultError) : super();

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Logger.write('onError ${err.requestOptions.uri} - ${err.message}');
    handleError(err);
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(response.data['data'] != null) {
      response.data = response.data['data'];
      handler.next(response);
    } else {
      handler.next(response);
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final logs = <String>[
      '${options.method} ${options.uri}',
      if (options.queryParameters.isNotEmpty) 'Query: ${options.queryParameters}',
      if (options.data.isNotEmpty) 'Body: ${options.data}',
    ];

    final msg = logs.join('\n');

    Logger.write(msg);

    handler.next(options);
  }

  void handleError(DioError err) {
    int? statusCode = err.response?.statusCode;
    String title = "${S.current.Loi} ${statusCode ?? ""}";
    String message = "";
    if (statusCode == 401 && !err.requestOptions.path.contains("credentials")) {
      UserStore.to.switchStatusLogin(false);
      UserStore.to.onLogout();
      message = S.current.Het_phien_lam_viec;
    } else {
      message = err.response?.data?["ResponseStatus"]["Message"] ?? err.message;
    }
    Loading.dismiss();
    if (showDefaultError && message.isNotEmpty) {
      CustomSnackBar.error(title: title, message: message);
    }
  }
}
