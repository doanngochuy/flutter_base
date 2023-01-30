import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int top;
  final int skip;

  static const $defaultItemPerPage = 20;

  const Pagination({
    this.top = $defaultItemPerPage,
    this.skip = 0,
  });

  @override
  List<Object?> get props => [top, skip];
}
