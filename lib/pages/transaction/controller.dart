import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:get/get.dart';

import '../../common/entities/entities.dart';
import '../../common/store/store.dart';
import 'state.dart';

class TransactionController extends GetxController {
  static TransactionController get to => Get.find<TransactionController>();

  final state = TransactionState();

  Future _handleInitData() async {
    try {
      state.resetLoadMoreCounter();
      await _handleGetTrans();
    } catch (e) {
      CustomSnackBar.error(
        title: S.current.Loi,
        message: S.current.Da_co_loi_xay_ra,
      );
    }
  }

  Future initData() async {
    if (state.transactions.isEmpty) {
      await Loading.openAndDismissLoading(_handleInitData);
    } else {
      _handleInitData();
    }
  }

  /// Call API
  Future _handleGetTrans() async {
    state.setDataState(await getTrans());
  }

  Future<ResponseTransaction> getTrans() => JobStore.to.getTransactions(
        page: state.loadMoreCounter.pageNumber,
        pageSize: state.loadMoreCounter.itemPerPages,
      );

  /// Logic Mobile
  Future onLoading() async {
    if (state.transactions.length >= state.count) {
      state.refreshController.loadComplete();
      return;
    }
    try {
      state.setLoadMoreCounter(state.loadMoreCounter.next());
      state.addTransactions(await getTrans());
      state.refreshController.loadComplete();
    } catch (e) {
      state.refreshController.loadFailed();
    }
  }

  void onRefresh() async {
    try {
      state.resetLoadMoreCounter();
      await _handleGetTrans();
      state.refreshController.refreshCompleted();
    } catch (e) {
      state.refreshController.refreshFailed();
    }
  }
}
