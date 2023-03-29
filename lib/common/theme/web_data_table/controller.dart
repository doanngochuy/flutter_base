import 'package:flutter/material.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/utils/extensions/extensions.dart';

class WebDataTableController<T> extends ChangeNotifier {
  List<T> get dataSources => _dataSources;
  var _dataSources = <T>[];

  int get itemCount => _totalCount;
  var _totalCount = 0;

  TablePaginationData get paginationData => _paginationData;
  final _paginationData = TablePaginationData();

  WebDataTableController({
    List<T> dataSources = const [],
    int totalCount = 0,
    int currentPage = 1,
  })  : _dataSources = dataSources,
        _totalCount = totalCount;

  void sort([int Function(T a, T b)? compare]) {
    _dataSources.sort(compare);
    notifyListeners();
  }

  void setTotalCount(int totalCount) {
    _totalCount = totalCount;
    notifyListeners();
  }

  void setDataSources(List<T> dataSources) {
    _dataSources = dataSources;
    notifyListeners();
  }

  void resetFirstPage() {
    _paginationData.currentPage = 1;
    handleArrangeStartToEnd();
    notifyListeners();
  }

  void reloadDataTable() => notifyListeners();

  void handleArrangeStartToEnd() {
    _paginationData.excessStart = _paginationData.currentPage - _paginationData.numberNextPage <= 0
        ? _paginationData.numberNextPage - (_paginationData.currentPage - 1)
        : 0;
    _paginationData.excessEnd =
        _paginationData.currentPage + _paginationData.numberNextPage >= _paginationData.pageNumber
            ? _paginationData.numberNextPage -
                (_paginationData.pageNumber - _paginationData.currentPage)
            : 0;
    _paginationData.startPage = _paginationData.currentPage - _paginationData.numberNextPage <= 0
        ? 1
        : _paginationData.currentPage - _paginationData.numberNextPage - _paginationData.excessEnd;
    _paginationData.endPage =
        _paginationData.currentPage + _paginationData.numberNextPage >= _paginationData.pageNumber
            ? _paginationData.pageNumber
            : _paginationData.currentPage +
                _paginationData.numberNextPage +
                _paginationData.excessStart;
  }

  int calculatePageNumber() => (_totalCount / _paginationData.currentItemsPerPage).ceil();

  void handleInitData() => _paginationData.pageNumber = calculatePageNumber();
}

const $defaultItemsPerPage = 20;
const $defaultListItemPerPage = [20, 30, 50];

class TablePaginationData {
  int pageNumber;
  int currentItemsPerPage;
  var excessStart = 0;
  var excessEnd = 0;
  var startPage = 0;
  var endPage = 0;
  var listItemsPerPage = $defaultListItemPerPage;
  var currentPage = 1;

  int get numberNextPage => ConfigStore.to.screenWidth.isDesktop ? 3 : 2;

  TablePaginationData({
    this.pageNumber = 1,
    this.currentItemsPerPage = $defaultItemsPerPage,
  });
}
