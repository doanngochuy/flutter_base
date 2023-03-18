import 'dart:convert';
import 'dart:io';

import 'package:flutter_base/common/di/injector.dart';
import 'package:flutter_base/common/entities/entities.dart';
import 'package:flutter_base/common/local/local_database.dart';
import 'package:flutter_base/common/local/prefs/prefs_sevice.dart';
import 'package:flutter_base/common/remote/remote.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/common/utils/logger.dart';
import 'package:flutter_base/common/values/values.dart';
import 'package:get/get.dart';

//authen, subdomain, domain
abstract class UserStore {
  static UserStore get to => AppInjector.injector<UserStore>();

  RxBool get isLogin;

  String get accessToken;

  bool get hasToken;

  Future<LoginResponse> login(
    String userName,
    String passwords,
  );

  void switchStatusLogin(bool value);

  Future saveAccessToken(String value);

  Future saveUser(LoginResponse profile);

  LoginResponse getUser();

  Future saveVendorSession(List<dynamic> typeTransactions);

  Future onLogout();

  Future<void> onLogin({
    required String userName,
    required String passwords,
  });
}

class UserStoreImpl implements UserStore {
  @override
  final isLogin = false.obs;

  String _accessToken = '';

  @override
  String get accessToken => _accessToken;

  @override
  bool get hasToken => _accessToken.isNotEmpty;

  UserStoreImpl() {
    _accessToken = PrefsService.to.getString(AppStorage.accessToken);
    switchStatusLogin(hasToken);
  }

  @override
  Future<LoginResponse> login(
    String userName,
    String passwords,
  ) =>
      ApiService.create().login(
        {
          'userName': userName,
          'password': passwords,
        },
      );

  @override
  void switchStatusLogin(bool value) {
    isLogin.value = value;
  }

  @override
  Future saveAccessToken(String value) async {
    await PrefsService.to.setString(AppStorage.accessToken, value);
    _accessToken = value;
  }

  @override
  Future<void> saveUser(LoginResponse profile) async {
    PrefsService.to.setString(AppStorage.storageUserProfile, jsonEncode(profile));
  }

  @override
  LoginResponse getUser() => LoginResponse.fromJson(jsonDecode(
        PrefsService.to.getString(AppStorage.storageUserProfile),
      ));

  @override
  Future<void> saveVendorSession(List<dynamic> typeTransactions) async {
    for (Map<String, dynamic> element in typeTransactions) {
      if (element['Id'] != null && element['Name'] != null) {
        PrefsService.to.setString(element['Id'].toString(), element['Name'].toString());
      }
    }
  }

  @override
  Future<void> onLogout() async {
    if (isLogin.value) await ApiService.create().logout();
    await Future.wait([
      PrefsService.to.clear(),
      AppLocalDatabase.to.clear(),
      SignalRService.to.stop(),
    ]);
    ConfigStore.to.setTypeLogin(null);
    _accessToken = '';
    switchStatusLogin(false);
  }

  @override
  Future onLogin({
    required String userName,
    required String passwords,
  }) async {
    try {
      final loginResponse = await login(userName, passwords);
      print(loginResponse.toJson());
      saveAccessToken(loginResponse.accessToken);
      switchStatusLogin(true);
    } on HttpException catch (e) {
      debugConsoleLog(e.message);
    }
  }
}
