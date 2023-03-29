import 'package:equatable/equatable.dart';

class LoadMoreCounter extends Equatable {
  final int pageNumber;
  final int itemPerPages;
  final int totalItem;

  static const $defaultItemPerPage = 10;

  int get offset => pageNumber * itemPerPages;

  const LoadMoreCounter({
    this.pageNumber = 1,
    this.itemPerPages = $defaultItemPerPage,
    this.totalItem = 0,
  });

  LoadMoreCounter cloneInstance({
    int? pageNumber,
    int? itemPerPages,
    int? totalItem,
  }) =>
      LoadMoreCounter(
        pageNumber: pageNumber ?? this.pageNumber,
        itemPerPages: itemPerPages ?? this.itemPerPages,
        totalItem: totalItem ?? this.totalItem,
      );

  LoadMoreCounter next() => cloneInstance(pageNumber: pageNumber + 1);

  @override
  List<Object?> get props => [
        pageNumber,
        itemPerPages,
        totalItem,
      ];
}
