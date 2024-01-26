import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WithdrawState {
  /// Data State
  final _timeStamp = Rx<DateTime?>(null);
  DateTime? get timeStamp => _timeStamp.value;
  void setTimeStamp(DateTime? value) => _timeStamp.value = value;

  final _count = RxInt(0);
  int get count => _count.value;
  void setCount(int value) => _count.value = value;

  final _totalMoney = RxInt(0);
  int get totalMoney => _totalMoney.value;

  final _withdraws = RxList<Withdraw>([]);
  List<Withdraw> get withdraws => _withdraws;
  void setWithdraws(List<Withdraw> value) => _withdraws.value = value;

  void addWithdraws(ResponseSync<Withdraw> response) {
    setCount(response.metadata.totalItems);
    _withdraws.addAll(response.data);
    _withdraws.refresh();
  }

  void setDataState(ResponseSync<Withdraw> response) {
    setCount(response.metadata.totalItems);
    setWithdraws(response.data);
  }

  /// Logic Mobile
  RefreshController refreshController = RefreshController();
  LoadMoreCounter _loadMoreCounter = const LoadMoreCounter();

  LoadMoreCounter get loadMoreCounter => _loadMoreCounter;

  void setLoadMoreCounter(LoadMoreCounter value) => _loadMoreCounter = value;

  void resetRefreshController() => refreshController = RefreshController();

  void resetLoadMoreCounter() => setLoadMoreCounter(const LoadMoreCounter());
}
