import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter_base/common/di/injector.dart';

abstract class SearchStream {
  static SearchStream get to => AppInjector.injector<SearchStream>();

  String get searchKeyword;

  Stream<String> get stream;

  void add(String value);
}

class SearchStreamImpl extends GetxController implements SearchStream {
  SearchStreamImpl.init();

  final _searchKeyword = ''.obs;

  @override
  String get searchKeyword => _searchKeyword.value;

  @override
  Stream<String> get stream => _searchKeyword.stream;

  @override
  void add(String value) => _searchKeyword.value = value;
}
