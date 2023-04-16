import 'package:EMO/common/di/injector.dart';
import 'package:EMO/common/store/store.dart';

import '../entities/entities.dart';
import '../remote/remote.dart';

abstract class JobStore {
  static JobStore get to => AppInjector.injector<JobStore>();

  Future<CurrentJobResponse> getCurrentJob();

  Future<StartJobResponse> startJob(int jobId, int currentId);

  Future finishJob(String token, String valuePage);

  Future<ResponseJob> getDoneJobs({
    int pageSize,
    int page,
    String sort,
    String order,
  });
}

class JobStoreImpl implements JobStore {
  @override
  Future<CurrentJobResponse> getCurrentJob() async {
    final deviceId = await UserStore.to.getDeviceId();
    return ApiService.create().getCurrentJob(deviceId: deviceId ?? "");
  }

  @override
  Future<StartJobResponse> startJob(int jobId, int currentId) =>
      ApiService.create().startJob(jobId: jobId, currentId: currentId);

  @override
  Future finishJob(String token, String valuePage) async {
    final request = {
      "token": token,
      "value_page": valuePage,
      "imei": (await UserStore.to.getDeviceId()) ?? "",
    };

    return ApiService.create().finishJob(request: request);
  }

  @override
  Future<ResponseJob> getDoneJobs({
    int pageSize = 10,
    int page = 1,
    String sort = "id",
    String order = "desc",
  }) =>
      ApiService.create().getDoneJobs(
        pageSize: pageSize,
        page: page,
        sort: sort,
        order: order,
      );
}
