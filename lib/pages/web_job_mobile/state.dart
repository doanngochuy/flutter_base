import 'package:get/get.dart';

import '../../common/entities/entities.dart';

class GetJobState {
  Job? job;
  int? currentId;
  StartJobResponse? startJobResponse;

  final keyWordHintId = 'search-key-hint';

  final Rx<JobStatus> _statusJob = JobStatus.none.obs;

  JobStatus get jobStatus => _statusJob.value;

  Stream<JobStatus> get statusJobStream => _statusJob.stream;

  setJobStatus(JobStatus value) => _statusJob.value = value;

}

enum Event {
  startJob,
  timeOut,
  finishJob,
}
