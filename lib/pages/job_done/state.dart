import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class JobState {
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

  final _mapJobs = RxList<MapJob>([]);
  List<MapJob> get mapJobs => _mapJobs;
  void setJobs(List<MapJob> value) => _mapJobs.value = value;

  void addJobs(ResponseJob response) {
    setCount(response.metadata.totalItems);
    setTotalMoney(response.totalMoney);
    _mapJobs.addAll(response.data);
    _mapJobs.refresh();
  }

  void setDataState(ResponseJob response) {
    setCount(response.metadata.totalItems);
    setTotalMoney(response.totalMoney);
    setJobs(response.data);
  }

  /// Logic Mobile
  RefreshController refreshController = RefreshController();
  LoadMoreCounter _loadMoreCounter = const LoadMoreCounter();

  LoadMoreCounter get loadMoreCounter => _loadMoreCounter;

  void setLoadMoreCounter(LoadMoreCounter value) => _loadMoreCounter = value;

  void resetRefreshController() => refreshController = RefreshController();

  void resetLoadMoreCounter() => setLoadMoreCounter(const LoadMoreCounter());
}
