import 'package:equatable/equatable.dart';

class PagedAndSortedResult<T> extends Equatable {
  final int totalCount;
  final List<T> items;

  const PagedAndSortedResult({
    required this.totalCount,
    this.items = const [],
  });

  @override
  List<Object?> get props => [totalCount, items];
}
