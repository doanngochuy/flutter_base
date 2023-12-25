import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TransactionState {
  /// Data State

  final _timeStamp = Rx<DateTime?>(null);
  DateTime? get timeStamp => _timeStamp.value;
  void setTimeStamp(DateTime? value) => _timeStamp.value = value;

  final _count = RxInt(0);
  int get count => _count.value;
  void setCount(int value) => _count.value = value;

  final _totalMoney = RxInt(0);
  int get totalMoney => _totalMoney.value;
  void setTotalMoney(int value) => _totalMoney.value = value;

  final _totalWithdraw = RxInt(0);
  int get totalWithdraw => _totalWithdraw.value;
  void setTotalWithdraw(int value) => _totalWithdraw.value = value;

  final _transactions = RxList<Transaction>([]);
  List<Transaction> get transactions => _transactions;
  void setTransactions(List<Transaction> value) => _transactions.value = value;

  void addTransactions(ResponseTransaction response) {
    setCount(response.metadata.totalItems);
    setTotalMoney(response.totalMoney);
    setTotalWithdraw(response.totalWithdraw);
    _transactions.addAll(response.data);
    _transactions.refresh();
  }

  void setDataState(ResponseTransaction response) {
    setCount(response.metadata.totalItems);
    setTotalMoney(response.totalMoney);
    setTransactions(response.data);
  }

  /// Logic Mobile
  RefreshController refreshController = RefreshController();
  LoadMoreCounter _loadMoreCounter = const LoadMoreCounter();

  LoadMoreCounter get loadMoreCounter => _loadMoreCounter;

  void setLoadMoreCounter(LoadMoreCounter value) => _loadMoreCounter = value;

  void resetRefreshController() => refreshController = RefreshController();

  void resetLoadMoreCounter() => setLoadMoreCounter(const LoadMoreCounter());
}
