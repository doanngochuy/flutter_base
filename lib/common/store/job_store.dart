import 'package:flutter_base/common/di/injector.dart';

import '../entities/entities.dart';
import '../remote/remote.dart';

abstract class JobStore {
  static JobStore get to => AppInjector.injector<JobStore>();

  Future<CurrentJobResponse> getCurrentJob();

  Future<StartJobResponse> startJob(int jobId, int currentId);

  Future finishJob(String token, String valuePage);
}

class JobStoreImpl implements JobStore {
  @override
  Future<CurrentJobResponse> getCurrentJob() => ApiService.create().getCurrentJob();

  @override
  Future<StartJobResponse> startJob(int jobId, int currentId) =>
      ApiService.create().startJob(jobId: jobId, currentId: currentId);

  @override
  Future finishJob(String token, String valuePage) =>
      ApiService.create().finishJob(token: token, valuePage: valuePage);
}
