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
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

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

  Future<String?> getDeviceId();
}

class UserStoreImpl implements UserStore {
  UserStoreImpl() {
    _accessToken = PrefsService.to.getString(AppStorage.accessToken);
    switchStatusLogin(hasToken);
    final jsonString = PrefsService.to.getString(AppStorage.storageUser);
    final json = jsonString.isNotEmpty ? jsonDecode(jsonString) : null;
    print('json: $json');
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
    try {
      final loginResponse = await ApiService.create().login(
        {'userName': userName, 'password': passwords},
      );
      await _saveAccessToken(loginResponse.accessToken);
      final user = await ApiService.create().getUser();
      await _saveUser(user);
      switchStatusLogin(true);
    } on HttpException catch (e) {
      debugConsoleLog(e.message);
    }
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
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }

    return null;
  }
}
