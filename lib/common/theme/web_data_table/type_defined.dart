import 'package:flutter/material.dart';
import 'package:EMO/common/config/config.dart';

enum WebDataTableSortType { none, asc, desc }

typedef WebTableItemWidget<T> = Widget Function(
  dynamic value,
  T rowData,
  String columnKey,
  String columnName,
  double? width,
  List<ScreenWidth>? showOnScreens,
);

class WebDataTableColumn<T> {
  WebDataTableColumn({
    required this.key,
    required this.name,
    this.width,
    this.flex,
    this.showOnScreens,
    this.customizeItemWidget,
  });

  final String key;
  final String name;
  final double? width;
  final int? flex;
  final List<ScreenWidth>? showOnScreens;
  final WebTableItemWidget<T>? customizeItemWidget;
}

typedef ShowerMoreContentRowWidget<T> = Widget Function(T rowData);

typedef AsyncDataGetter<T> = Future<List<T>> Function({required int skip, required int top});

typedef TopContentTable = Widget Function(List<WebDataTableColumn> columns);

typedef SortDataVoid = void Function(String keyColumn, WebDataTableSortType typeSort);
