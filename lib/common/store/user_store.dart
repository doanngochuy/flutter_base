import 'dart:convert';
import 'dart:io';

import 'package:EMO/common/di/injector.dart';
import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/local/local_database.dart';
import 'package:EMO/common/local/prefs/prefs_sevice.dart';
import 'package:EMO/common/remote/remote.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/utils/logger.dart';
import 'package:EMO/common/values/values.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:platform_device_id/platform_device_id.dart';

abstract class UserStore {
  static UserStore get to => AppInjector.injector<UserStore>();

  RxBool get isLogin;

  String get accessToken;

  bool get hasToken;

  User get user;

  void switchStatusLogin(bool value);

  Future onLogout();

  Future onLogin({
    required String userName,
    required String passwords,
  });

  Future onSignUp({
    required String userName,
    required String passwords,
    required String fullName,
    required String email,
  });

  Future updateUser({
    String? userName,
    String? fullName,
    String? email,
    bool? isActive,
  });

  Future blockUser();

  Future<String?> getDeviceId();
}

class UserStoreImpl implements UserStore {
  UserStoreImpl() {
    _accessToken = PrefsService.to.getString(AppStorage.accessToken);
    switchStatusLogin(hasToken);
    final jsonString = PrefsService.to.getString(AppStorage.storageUser);
    final json = jsonString.isNotEmpty ? jsonDecode(jsonString) : null;
    _user = json != null ? User.fromJson(json) : const User();
  }

  @override
  final isLogin = false.obs;

  @override
  void switchStatusLogin(bool value) {
    isLogin.value = value;
  }

  String _accessToken = '';

  Future _saveAccessToken(String value) async {
    await PrefsService.to.setString(AppStorage.accessToken, value);
    _accessToken = value;
  }

  @override
  String get accessToken => _accessToken;

  User _user = const User();

  Future _saveUser(User value) async {
    await PrefsService.to.setString(AppStorage.storageUser, value.toString());
    _user = value;
  }

  @override
  User get user => _user;

  @override
  bool get hasToken => _accessToken.isNotEmpty;

  @override
  Future<void> onLogout() async {
    switchStatusLogin(false);
    if (isLogin.value) await ApiService.create().logout();
    await Future.wait([
      PrefsService.to.clear(),
      AppLocalDatabase.to.clear(),
    ]);
    ConfigStore.to.setTypeLogin(null);
    _accessToken = '';
    _user = const User();
  }

  @override
  Future onLogin({
    required String userName,
    required String passwords,
  }) async {
    final loginResponse = await ApiService.create(showDefaultError: false).login(
      {'userName': userName, 'password': passwords},
    );
    await _saveAccessToken(loginResponse.accessToken);
    final user = await ApiService.create().getUser();
    await _saveUser(user);
    switchStatusLogin(true);
  }

  @override
  Future onSignUp({
    required String userName,
    required String passwords,
    required String fullName,
    required String email,
  }) async {
    try {
      await ApiService.create().signup(
        {
          "user_name": userName,
          "full_name": fullName,
          "email": email,
          "password": passwords,
          "role": "guest",
        },
      );
    } on HttpException catch (e) {
      debugConsoleLog(e.message);
    }
  }

  @override
  Future<String?> getDeviceId() async {
    String? deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'unknown';
    }
    return deviceId;
  }

  @override
  Future updateUser({
    String? userName,
    String? fullName,
    String? email,
    bool? isActive,
  }) {
    return ApiService.create().updateUser(
      request: {
        "user_name": userName,
        "full_name": fullName,
        "email": email,
        "is_active": isActive,
      },
    );
  }

  @override
  Future blockUser() async {
    try {
      await updateUser(isActive: false);
      await onLogout();
    } catch (e) {
      debugConsoleLog(e);
    }
  }
}
