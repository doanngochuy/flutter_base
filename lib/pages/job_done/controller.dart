import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:get/get.dart';

import '../../common/entities/entities.dart';
import '../../common/store/store.dart';
import 'state.dart';

class JobDoneController extends GetxController {
  static JobDoneController get to => Get.find<JobDoneController>();

  final state = JobState();

  Future _handleInitData() async {
    try {
      state.resetLoadMoreCounter();
      await _handleGetJobs();
    } catch (e) {
      CustomSnackBar.error(
        title: S.current.Loi,
        message: S.current.Da_co_loi_xay_ra,
      );
    }
  }

  Future initData() async {
    if (state.mapJobs.isEmpty) {
      await Loading.openAndDismissLoading(_handleInitData);
    } else {
      _handleInitData();
    }
  }

  /// Call API
  Future _handleGetJobs() async {
    state.setDataState(await getJobs());
  }

  Future<ResponseJob> getJobs() => JobStore.to.getDoneJobs(
        page: state.loadMoreCounter.pageNumber,
        pageSize: state.loadMoreCounter.itemPerPages,
      );

  /// Logic Mobile
  Future onLoading() async {
    if (state.mapJobs.length >= state.count) {
      state.refreshController.loadComplete();
      return;
    }
    try {
      state.setLoadMoreCounter(state.loadMoreCounter.next());
      state.addJobs(await getJobs());
      state.refreshController.loadComplete();
    } catch (e) {
      state.refreshController.loadFailed();
    }
  }

  void onRefresh() async {
    try {
      state.resetLoadMoreCounter();
      await _handleGetJobs();
      state.refreshController.refreshCompleted();
    } catch (e) {
      state.refreshController.refreshFailed();
    }
  }
}
