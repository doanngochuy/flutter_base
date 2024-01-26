import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:get/get.dart';

import '../../common/entities/entities.dart';
import '../../common/store/store.dart';
import 'state.dart';

class WithdrawController extends GetxController {
  static WithdrawController get to => Get.find<WithdrawController>();

  final state = WithdrawState();

  Future _handleInitData() async {
    try {
      state.resetLoadMoreCounter();
      await _handleGetWithdraws();
    } catch (e) {
      CustomSnackBar.error(
        title: S.current.Loi,
        message: S.current.Da_co_loi_xay_ra,
      );
    }
  }

  Future initData() async {
    if (state.withdraws.isEmpty) {
      await Loading.openAndDismissLoading(_handleInitData);
    } else {
      _handleInitData();
    }
  }

  /// Call API
  Future _handleGetWithdraws() async {
    state.setDataState(await getWithdraws());
  }

  Future<ResponseSync<Withdraw>> getWithdraws() => WithdrawStore.to.getWithdraws(
        page: state.loadMoreCounter.pageNumber,
        pageSize: state.loadMoreCounter.itemPerPages,
      );

  /// Logic Mobile
  Future onLoading() async {
    if (state.withdraws.length >= state.count) {
      state.refreshController.loadComplete();
      return;
    }
    try {
      state.setLoadMoreCounter(state.loadMoreCounter.next());
      state.addWithdraws(await getWithdraws());
      state.refreshController.loadComplete();
    } catch (e) {
      state.refreshController.loadFailed();
    }
  }

  void onRefresh() async {
    try {
      state.resetLoadMoreCounter();
      await _handleGetWithdraws();
      state.refreshController.refreshCompleted();
    } catch (e) {
      state.refreshController.refreshFailed();
    }
  }
}
