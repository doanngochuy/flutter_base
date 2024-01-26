import 'dart:async';

import 'package:EMO/common/di/injector.dart';
import 'package:EMO/common/store/store.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'base_service.dart';

class Tags {
  static const String apiError = "ApiError";
  static const String apiResponse = "ApiResponse";
}

abstract class AnalyticsService extends BaseService {
  static AnalyticsService get to => AppInjector.injector<AnalyticsService>();

  void logApiError(String apiName, String error);

  void logApiResponse(String apiName, String response);
}

class FireBaseAnalyticsService implements AnalyticsService {
  final analytics = FirebaseAnalytics.instance;
  late final observer = FirebaseAnalyticsObserver(analytics: analytics);
  late StreamSubscription streamSubscription;

  @override
  void disposeService() {
    streamSubscription.cancel();
  }

  @override
  void initService() {
    updateUser();
    analytics.logAppOpen();
    streamSubscription = UserStore.to.isLogin.listen((isLogin) {
      if (isLogin) updateUser();
    });
  }

  void logEvent(String name, Map<String, dynamic> parameters) {
    analytics.logEvent(name: name, parameters: parameters);
  }

  void updateUser() {
    final user = UserStore.to.user;
    _setUserId(user.id.toString());
    _setUserProperty("userName", user.userName);
  }

  void _setUserId(String id) {
    analytics.setUserId(id: id);
  }

  void _setUserProperty(String name, String value) {
    analytics.setUserProperty(name: name, value: value);
  }

  void setCurrentScreen(String screenName, String screenClassOverride) {
    analytics.setCurrentScreen(screenName: screenName, screenClassOverride: screenClassOverride);
  }

  @override
  void logApiError(String apiName, String error) {
    logEvent(Tags.apiError, {
      "Api": apiName,
      "error": error,
    });
  }

  @override
  void logApiResponse(String apiName, String response) {
    logEvent(Tags.apiResponse, {
      "Api": apiName,
      "response": response,
    });
  }
}
